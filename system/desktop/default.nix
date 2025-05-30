{ lib, config, ... }: {
  options.desktop = {
    enable = lib.mkEnableOption "desktop environment";
    session = lib.mkOption {
      type = lib.types.enum [ "hyprland" "gnome" "i3" ];
      default = "hyprland";
      description = "Default desktop session";
    };
  };

  imports = [
    ./hyprland.nix
    ./gnome.nix
    ./i3.nix
  ];

  config = lib.mkIf config.desktop.enable {
    # Common X11/Wayland configuration
    services.xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    services.libinput.enable = true;

    # Enable specific desktop sessions conditionally
    programs.hyprland.enable = lib.mkDefault (config.desktop.session == "hyprland");
    services.desktopManager.gnome.enable = lib.mkDefault (config.desktop.session == "gnome");
    services.xserver.windowManager.i3.enable = lib.mkDefault (config.desktop.session == "i3");
  };
}