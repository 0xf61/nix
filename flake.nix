{
  description = "NixEK Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixos-hardware, nix-darwin }:
    let
      nixosModules = [
        ./system
        ./user/packages.nix
      ];
    in
    {
      nixosConfigurations = {
        eqr = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = nixosModules ++ [
            ./hosts/eqr
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-pc-ssd
          ];
        };

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

      darwinConfigurations = {
        sc20 = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = import nixpkgs { 
            system = "aarch64-darwin"; 
            config.allowUnfree = true; 
          };
          modules = [
            ./hosts/sc20
            ./user/packages.nix
          ];
        };
      };
    };
}