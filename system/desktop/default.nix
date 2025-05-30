{ lib, config, ... }: {
  options.desktop = {
    enable = lib.mkEnableOption "desktop environment";
    defaultSession = lib.mkOption {
      type = lib.types.enum [ "hyprland" "gnome" "i3" ];
      default = "hyprland";
      description = "Default desktop session";
    };
    hyprland.enable = lib.mkEnableOption "Hyprland desktop environment";
    gnome.enable = lib.mkEnableOption "GNOME desktop environment";
    i3.enable = lib.mkEnableOption "i3 window manager";
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

    # Enable specific desktop sessions based on individual options
    programs.hyprland.enable = lib.mkDefault config.desktop.hyprland.enable;
    services.desktopManager.gnome.enable = lib.mkDefault config.desktop.gnome.enable;
    services.xserver.windowManager.i3.enable = lib.mkDefault config.desktop.i3.enable;

    # Set default session for display manager
    services.displayManager.defaultSession = lib.mkDefault (
      if config.desktop.gnome.enable && config.desktop.defaultSession == "gnome" then "gnome"
      else if config.desktop.hyprland.enable && config.desktop.defaultSession == "hyprland" then "hyprland-uwsm"
      else if config.desktop.i3.enable && config.desktop.defaultSession == "i3" then "none+i3"
      else if config.desktop.hyprland.enable then "hyprland-uwsm"
      else if config.desktop.gnome.enable then "gnome"
      else if config.desktop.i3.enable then "none+i3"
      else "hyprland-uwsm"
    );
  };
}