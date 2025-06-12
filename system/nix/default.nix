{ pkgs, lib, ... }: {
  nix = {
    gc.automatic = false;
    package = pkgs.lix;

    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";

    settings = {
      flake-registry = "/etc/nix/registry.json";
      auto-optimise-store = true;
      builders-use-substitutes = true;
      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];
      commit-lockfile-summary = "chore: Update flake.lock";
      accept-flake-config = true;
      keep-derivations = true;
      keep-outputs = true;
      warn-dirty = false;

      sandbox = true;
      max-jobs = "auto";
      keep-going = true;
      log-lines = 20;
      extra-experimental-features = [ "flakes" "nix-command" "repl-flake" ];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      ];
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # C/C++ toolchain libraries
      stdenv.cc.cc.lib
      glibc

      # Common system libraries
      openssl
      curl
      libz
      zlib

      # Development libraries
      libgcc

      # Additional common dependencies
      expat
      fontconfig
      freetype
      libGL
      libxkbcommon
      xorg.libX11
      xorg.libXcursor
      xorg.libXi
      xorg.libXrandr
    ];
  };

  # Enable nh for managing generations and cleaning on Linux systems
  lib.mkIf pkgs.stdenv.isLinux {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/user/git/nix"; # Consider making this path relative or a variable
    };
  }; # Added semicolon

  systemd.services.nix-daemon = { environment.TMPDIR = "/var/tmp"; };

  system.switch = {
    enable = false;
    enableNg = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
    };
  };
}
