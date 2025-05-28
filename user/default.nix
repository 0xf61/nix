{
  theme = import ./theme;
  module = { pkgs, ... }: {
    config = {
      # Hyprland configuration moved to system/desktop/hyprland.nix
      programs.direnv = {
        enable = false;
        enableFishIntegration = false;
      };
      programs.fish.enable = true;
    };
    imports = [ ./packages.nix ];
  };
}
