{ lib, config, pkgs, ... }: {
  config = lib.mkIf (config.desktop.enable && config.desktop.hyprland.enable) {
    # Enable Hyprland in NixOS
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    # Display manager configuration
    services.displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };

    # Essential Hyprland packages
    environment.systemPackages = with pkgs; [
      # Core Hyprland utilities
      hyprpaper
      hyprlock
      hyprshot
      
      # Wayland utilities
      wl-clipboard
      xdg-desktop-portal-hyprland
      
      # System utilities
      waybar
      wofi
      mako
      pavucontrol
      brightnessctl
      playerctl
      swayidle
      grim
      slurp
      
      # Authentication and secrets
      gnome-keyring
      libsecret
      seahorse
      polkit_gnome
    ];

    # Hardware acceleration
    hardware.graphics.enable = true;
  };
}