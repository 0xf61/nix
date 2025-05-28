{ config, lib, pkgs, ... }: {
  imports = [
    ./gnome.nix
    ./i3.nix
    ./hyprland.nix
  ];

  # Common X11 configuration
  services.xserver = {
    enable = true;
    
    # Use GDM as the default display manager for all environments
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    
    # Disable xterm as it's not needed
    desktopManager.xterm.enable = false;

    # Common X11 keyboard configuration
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable common input drivers
  services.libinput.enable = true;
}