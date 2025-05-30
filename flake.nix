{
  description = "NixEK Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }:
    let
      # Common configuration modules
      commonModules = [
        ./system
        ./user
      ];

      # Helper function to create host configurations
      mkHost = name: system: extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            { networking.hostName = name; }
            ./hosts/${name}
          ] ++ commonModules ++ extraModules;

          specialArgs = {
            inherit self nixos-hardware;
            flake = self;
          };
        };
    in {
      nixosConfigurations = {
        eqr = mkHost "eqr" "x86_64-linux" [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
        ];

        lap = mkHost "lap" "x86_64-linux" [
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-gpu-nvidia
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc-laptop-ssd
        ];
      };
    };
}
