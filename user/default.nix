{
  theme = import ./theme;
  module = { pkgs, ... }: {
    config = {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };
      programs.direnv = {
        enable = false;
        enableFishIntegration = false;
      };
      programs.fish.enable = true;
    };
    imports = [ ./packages.nix ];
  };
}
