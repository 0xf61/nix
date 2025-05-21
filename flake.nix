{
  description = "NixEK";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { nixpkgs, ... }@inputs:
    let user = import ./user;
    in {

      # nixosConfigurations = {
      #   # Define your NixOS configurations here
      #   eqr = nixpkgs.lib.nixosSystem {
      #     system = "x86_64-linux";
      #     modules = [ ./configuration.nix ];
      #     specialArgs = { inherit self; };
      #   };
      # };

      nixosModules = {
        system = import ./system;

        user = user.module;

        # place for my home brew modules
      } // import ./modules;
      nixosConfigurations = import ./hosts inputs;

    };
}
