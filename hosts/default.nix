{ nixpkgs, nixos-hardware, self, ... }:
let
  inherit (self) inputs;
  mkHost = name: system: extraModules:
    nixpkgs.lib.nixosSystem {
      modules = [
        {
          networking.hostName = name;
          nixpkgs.hostPlatform = system;
        }
        ./${name}
      ] ++ extraModules ++ builtins.attrValues self.nixosModules;

      # This allows to easily access flake inputs and outputs
      # from nixos modules, so it's a little bit cleaner
      specialArgs = {
        inherit inputs;
        flake = self;
      };
    };
in {
  eqr = mkHost "eqr" "x86_64-linux" [
    # Beelink mini PC hardware configuration
    # Using generic amd cpu optimizations - replace with specific model if available
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-pc-ssd
  ];

  lap = mkHost "lap" "x86_64-linux" [
    # Hardware configuration for Intel + NVIDIA laptop
    nixos-hardware.nixosModules.common-cpu-intel
    # nixos-hardware.nixosModules.common-gpu-nvidia
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];
}
