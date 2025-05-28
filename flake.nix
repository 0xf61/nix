{
  description = "NixEK";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { nixpkgs, ... }@inputs:
    let user = import ./user;
    in {
      nixosModules = {
        system = import ./system;
        user = user.module;
      };
      nixosConfigurations = import ./hosts inputs;

    };
}
