{
  description = "NixEK";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { nixpkgs, nixos-hardware, ... }@inputs:
    let user = import ./user;
    in {
      nixosModules = {
        system = import ./system;
        user = user.module;
      };
      nixosConfigurations = import ./hosts inputs;

    };
}
