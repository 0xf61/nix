{ lib, config, ... }: {
  options.desktop = {
    enable = lib.mkEnableOption "desktop environment";
    defaultSession = lib.mkOption {
      type = lib.types.enum [ "gnome" ];
      default = "gnome";
      description = "Default desktop session";
    };
    gnome.enable = lib.mkEnableOption "GNOME desktop environment";
  };

  imports = [
    ./gnome.nix
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
    services.xserver.desktopManager.gnome.enable = lib.mkDefault config.desktop.gnome.enable;

    # Set default session for display manager
    services.displayManager.defaultSession = "gnome";
  };
}