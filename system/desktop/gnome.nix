{ config, lib, pkgs, ... }: {
  services.xserver.desktopManager.gnome = {
    enable = true;
    # You can add GNOME-specific configurations here
  };

  # Add common GNOME packages
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    dconf-editor
    adwaita-icon-theme
    gnome-themes-extra
  ];

  # Enable GNOME-specific services
  services.gnome = {
    core-apps.enable = true;
    core-shell.enable = true;
    gnome-keyring.enable = true;
    gnome-settings-daemon.enable = true;
  };

  # Enable Wayland support for GNOME
  services.xserver.displayManager.gdm.wayland = true;
}