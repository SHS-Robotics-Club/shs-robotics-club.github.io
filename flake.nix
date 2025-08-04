{
  description = "HUGO Static Site Generator";

  nixConfig = {
    extra-substituters = ["https://cache.nixos.org"];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    systems.url = "github:nix-systems/default";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    actions-nix.url = "github:nialov/actions.nix";
    papermod = {
      url = "github:adityatelange/hugo-PaperMod";
      flake = false;
    };
  };

  outputs = inputs @ {
    flake-parts,
    systems,
    self,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;

      imports = [
        inputs.flake-root.flakeModule
        inputs.git-hooks-nix.flakeModule
        inputs.treefmt-nix.flakeModule
        inputs.actions-nix.flakeModules.default
      ];

      perSystem = {
        pkgs,
        config,
        ...
      }: {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "shsroboticsclub";
          src = self;
          buildPhase = ''
            cd ./shsrobotics.club
              mkdir -p themes
              ln -s ${inputs.papermod} themes/PaperMod
              ${pkgs.hugo}/bin/hugo
          '';
          installPhase = "cp -r public $out";
        };

        treefmt.config = {
          inherit (config.flake-root) projectRootFile;
          flakeCheck = false;
          programs = {
            actionlint.enable = true;
            yamlfmt.enable = true;
            alejandra.enable = true;
            typos = {
              enable = true;
              configFile = let
                tomlConfig = ''
                  [default.extend-words]
                  SHS = "SHS"
                '';
                tomlFile = pkgs.writeText "typos.toml" tomlConfig;
              in
                toString tomlFile;
            };
          };
        };

        devShells.default = pkgs.mkShell {
          name = "GOHUGO Dev Shell";
          buildInputs =
            [
              pkgs.hugo
              pkgs.git
              pkgs.go
              config.treefmt.build.wrapper
            ]
            ++ (pkgs.lib.attrValues config.treefmt.build.programs);
          shellHook = ''
            ${config.pre-commit.installationScript}
            echo 1>&2 "Welcome!"
          '';
        };

        pre-commit.settings.hooks = {
          check-added-large-files.enable = true; # Prevents adding large files to the repository
          check-case-conflicts.enable = true; # Detects filename case conflicts (useful for case-insensitive filesystems)
          check-merge-conflicts.enable = true; # Ensures no merge conflict markers are left in files
          commitizen.enable = true; # Enforces standardized commit message format (e.g., Conventional Commits)
          end-of-file-fixer.enable = true; # Ensures files end with a newline or are empty
          fix-byte-order-marker.enable = true; # Removes UTF-8 BOM (Byte Order Marker) from files
          mixed-line-endings.enable = true; # Resolves mixed line endings (CRLF vs LF)
          trufflehog.enable = true; # Scans for secrets (e.g., API keys, passwords) in the codebase
          treefmt = {
            enable = true;
            package = config.treefmt.build.wrapper; # Wrapper to the Treefmt module for formatting the code tree
          };
        };
      };

      flake.actions-nix = {
        pre-commit.enable = false;

        defaultValues.jobs = {
          runs-on = "ubuntu-latest";
          timeout-minutes = 30;
        };

        workflows = let
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
        in {
          ".github/workflows/nix-flake-check.yaml" = {
            name = "Nix: Flake Check";
            on = {
              push.branches = ["main"];
              workflow_dispatch = null;
            };
            jobs.nix-flake-check = {
              permissions.contents = "read";
              steps =
                commonSteps
                ++ [
                  {
                    name = "Flake checker";
                    uses = "DeterminateSystems/flake-checker-action@main";
                  }
                ];
            };
          };

          ".github/workflows/nix-flake-lock.yaml" = {
            name = "Nix: Flake Lock";
            on = {
              schedule = [{cron = "0 8 * * 1,5";}];
              workflow_dispatch = null;
            };
            jobs.nix-lock-update = {
              permissions = {
                contents = "write";
                pull-requests = "write";
              };
              steps =
                commonSteps
                ++ [
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
