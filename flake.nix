{
  description = "HUGO Static Site Generator";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    systems.url = "github:nix-systems/default";
    devshell.url = "github:numtide/devshell";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    actions-nix.url = "github:nialov/actions.nix";
  };
  outputs =
    inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      imports = [
        inputs.devshell.flakeModule
        inputs.flake-root.flakeModule
        inputs.git-hooks-nix.flakeModule
        inputs.treefmt-nix.flakeModule
        inputs.actions-nix.flakeModules.default
      ];
      perSystem =
        { pkgs, config, ... }:
        {
          treefmt.config = {
            inherit (config.flake-root) projectRootFile;
            flakeCheck = true;
            programs = {
              actionlint.enable = true;
              nixfmt = {
                enable = true;
                package = pkgs.nixfmt-rfc-style;
              };
            };
          };

          devshells.default = {
            name = "GOHUGO Dev Shell";
            motd = "Welcome";
            packages = [
              pkgs.hugo
              config.treefmt.build.wrapper
            ]
            ++ (pkgs.lib.attrValues config.treefmt.build.programs);
          };

          pre-commit.settings.hooks = {
            treefmt = {
              enable = true;
              package = config.treefmt.build.wrapper;
            };
          };
        };
      flake.actions-nix = {
        pre-commit.enable = true;
        defaultValues.jobs = {
          runs-on = "ubuntu-latest";
          timeout-minutes = 30;
        };
        workflows =
          let
            commonSteps = [
              {
                name = "Checkout repository";
                uses = "actions/checkout@v4";
              }
              {
                name = "Nix installer";
                uses = "DeterminateSystems/nix-installer-action@main";
              }
              {
                name = "Magic Nix Cache";
                uses = "DeterminateSystems/magic-nix-cache-action@main";
              }
            ];
          in
          {
            ".github/workflows/nix-flake-check.yaml" = {
              on = {
                push = {
                  branches = [ "main" ];
                };
                workflow_dispatch = null;
              };
              jobs.nix-flake-check = {
                name = "Flake Check";
                permissions = {
                  contents = "read";
                };
                steps = commonSteps ++ [
                  {
                    name = "Flake checker";
                    uses = "DeterminateSystems/flake-checker-action@main";
                  }
                ];
              };
            };

            ".github/workflows/flake-lock-update.yaml" = {
              name = "Flake Lock Update";
              on = {
                schedule = [ { cron = "0 8 * * 1,5"; } ];
                workflow_dispatch = null;
              };
              jobs.nix-lock-update = {
                name = "Update flake.lock";
                permissions = {
                  contents = "write";
                  pull-requests = "write";
                };
                steps = commonSteps ++ [
                  {
                    name = "Update flake.lock";
                    uses = "DeterminateSystems/update-flake-lock@main";
                    "with" = {
                      pr-title = "chore: update flake.lock";
                      pr-labels = "dependencies\nautomated";
                    };
                  }
                ];
              };
            };
          };
      };

    };
}
