{
  # This is the main Nix flake for managing your system configurations.
  # It defines inputs (external dependencies) and outputs (system configurations).
  description = "NixEK Configuration";

  # Define external flake inputs
  inputs = {
    # Nixpkgs: The main Nix packages collection
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    # NixOS Hardware: Common hardware configurations for NixOS
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # Nix-Darwin: Module for managing macOS systems with Nix
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    # Ensure nix-darwin uses the same nixpkgs as the rest of the flake
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Define the flake outputs
  outputs = { self, nixpkgs, nixos-hardware, nix-darwin }:
    let
      # Common modules for NixOS configurations (Linux hosts)
      nixosModules = [
        ./system        # System-wide settings (e.g., networking, services, users)
        ./user/packages.nix # Common user packages and fonts
      ];
    in
    {
      # Define NixOS configurations for various Linux hosts
      nixosConfigurations = {
        # 'eqr' host configuration
        eqr = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # Specify the system architecture
          modules = nixosModules ++ [ # Include common NixOS modules
            ./hosts/eqr # Host-specific configuration for 'eqr'
            nixos-hardware.nixosModules.common-cpu-amd # AMD CPU specific hardware settings
            nixos-hardware.nixosModules.common-pc-ssd # SSD specific hardware settings
          ];
        };

        # 'lap' host configuration
        lap = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = nixosModules ++ [
            ./hosts/lap
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-gpu-nvidia
            nixos-hardware.nixosModules.common-pc-laptop
            nixos-hardware.nixosModules.common-pc-laptop-ssd
          ];
        };
      };

      # Define Darwin (macOS) configurations
      darwinConfigurations = {
        # 'sc20' host configuration
        sc20 = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          # Override the default pkgs to allow unfree packages for this Darwin system
          pkgs = import nixpkgs { 
            system = "aarch64-darwin"; 
            config.allowUnfree = true; 
            config.allowUnsupportedSystem = true;
          };
          modules = [
            ./hosts/sc20 # Host-specific configuration for 'sc20' (macOS defaults, hostname)
            ./user/packages.nix # User packages and fonts
          ];
        };
      };
    };
}