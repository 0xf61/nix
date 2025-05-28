{ nixpkgs, self, ... }:
let
  inherit (self) inputs;
  mkHost = name: system:
    nixpkgs.lib.nixosSystem {
      modules = [
        {
          networking.hostName = name;
          nixpkgs.hostPlatform = system;
        }
        ./${name}
      ] ++ builtins.attrValues self.nixosModules;

      # This allows to easily access flake inputs and outputs
      # from nixos modules, so it's a little bit cleaner
      specialArgs = {
        inherit inputs;
        flake = self;
      };
    };
in {
  eqr = mkHost "eqr" "x86_64-linux";
  lap = mkHost "lap" "x86_64-linux";
}
