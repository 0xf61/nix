{ lib, config, pkgs, ... }: {
  config = lib.mkIf (config.desktop.enable && config.desktop.gnome.enable) {
    services.xserver.desktopManager.gnome.enable = true;

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

    # Disable GNOME keyring SSH to use GPG agent instead
    security.pam.services.gdm.enableGnomeKeyring = lib.mkForce false;
    security.pam.services.login.enableGnomeKeyring = lib.mkForce false;
  };
}