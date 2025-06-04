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

    # Hyprland-specific environment variables
    environment.sessionVariables = {
      # Wayland support
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      CLUTTER_BACKEND = "wayland";

      # Desktop session
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
