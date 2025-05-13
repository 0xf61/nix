{
  description = "NixEK";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; };

  outputs = { self, nixpkgs }: {

    nixosConfigurations = {
      # Define your NixOS configurations here
      eqr = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
        specialArgs = { inherit self; };
      };
    };

  };
}
