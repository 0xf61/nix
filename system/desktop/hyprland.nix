{ config, lib, pkgs, ... }: {
  # Enable Hyprland in NixOS
  programs.hyprland = {
    enable = true;
    # Enable the XDG desktop portal for Hyprland
    xwayland.enable = true;
    # Enable Use With SystemManagement (uwsm)
    withUWSM = true;
  };

  # Setting a default session for the login manager
  services.displayManager.defaultSession = "hyprland-uwsm";

  # Add Hyprland-specific packages
  environment.systemPackages = with pkgs; [
    # Core utilities for Hyprland
    hyprpaper  # Wallpaper
    hyprlock   # Screen locking
    hyprshot   # Screenshot utility
    
    # Wayland utilities
    wl-clipboard
    xdg-desktop-portal-hyprland
    
    # Audio control
    pavucontrol
    
    # Application launchers and system menus
    wofi
    waybar
    mako       # Notification daemon
    
    # Screen brightness, audio, etc.
    brightnessctl
    playerctl
    
    # Additional utilities
    swayidle
    grim
    slurp
  ];

  # Ensure appropriate environment variables are set
  environment.sessionVariables = {
    # Wayland-specific
    NIXOS_OZONE_WL = "1";
    # For applications using SDL to prefer Wayland
    SDL_VIDEODRIVER = "wayland";
    # For Qt applications
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # For ElementaryOS/Pantheon applications
    CLUTTER_BACKEND = "wayland";
    # For XDG Desktop Portal
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };
  
  # Hardware acceleration and graphics driver support
  hardware.graphics = {
    enable = true;
  };
}