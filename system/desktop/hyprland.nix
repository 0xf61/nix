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
    hyprpaper # Wallpaper
    hyprlock # Screen locking
    hyprshot # Screenshot utility

    # Wayland utilities
    wl-clipboard
    xdg-desktop-portal-hyprland

    # Audio control
    pavucontrol

    # Application launchers and system menus
    wofi
    waybar
    mako # Notification daemon

    # Screen brightness, audio, etc.
    brightnessctl
    playerctl

    # Additional utilities
    swayidle
    grim
    slurp
  ];

  # Environment variables moved to system/environment/default.nix

  # Hardware acceleration and graphics driver support
  hardware.graphics = { enable = true; };
}

