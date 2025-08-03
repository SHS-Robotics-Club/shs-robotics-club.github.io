[![Flake Check](https://github.com/SHS-Robotics-Club/-shs-robotics-club.github.io/actions/workflows/nix-flake-check.yaml/badge.svg)](https://github.com/SHS-Robotics-Club/-shs-robotics-club.github.io/actions/workflows/nix-flake-check.yaml)
[![Flake Lock Update](https://github.com/SHS-Robotics-Club/-shs-robotics-club.github.io/actions/workflows/flake-lock-update.yaml/badge.svg)](https://github.com/SHS-Robotics-Club/-shs-robotics-club.github.io/actions/workflows/flake-lock-update.yaml)
![Built with Nix](https://img.shields.io/badge/built%20with-nix-5277C3?logo=nixos&logoColor=white)
![Hugo](https://img.shields.io/badge/Hugo-extended%20%7C%20v0.124.1-blue?logo=hugo)
[![Theme](https://img.shields.io/badge/theme-PaperMod-lightgrey)](https://github.com/adityatelange/hugo-PaperMod)
[![License](https://img.shields.io/github/license/SHS-Robotics-Club/-shs-robotics-club.github.io)](https://github.com/SHS-Robotics-Club/-shs-robotics-club.github.io/blob/main/LICENSE)
[![Last Commit](https://img.shields.io/github/last-commit/SHS-Robotics-Club/-shs-robotics-club.github.io)](https://github.com/SHS-Robotics-Club/-shs-robotics-club.github.io/commits)

# SHS Robotics Club Website

This is the official website for the SHS Robotics Club, built with [Hugo](https://gohugo.io/) — a fast and flexible static site generator.

## 🚀 Getting Started

To run this site locally:

### 1. Install Hugo

You can install Hugo in one of two ways:

- **Option A: Official installation instructions**
  https://gohugo.io/getting-started/installing/

- **Option B: Use Nix (cross-platform, recommended for reproducibility)**
  Nix works on **macOS**, **Linux**, and **Windows (via WSL)**.
  To install Nix using the Determinate Systems installer:

  ```bash
  curl -L https://install.determinate.systems/nix | sh
  ```

  > ✅ **Note:** On Windows, use [WSL 2](https://learn.microsoft.com/en-us/windows/wsl/) and run the above commands inside a WSL terminal.

### 2. Clone this repository

   ```bash
   git clone https://github.com/SHS-Robotics-Club/-shs-robotics-club.github.io.git
   cd ./-shs-robotics-club.github.io
   ```

### 3. Run Hugo
