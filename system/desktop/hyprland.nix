{ pkgs, ... }: {
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
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

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

    # Secrets management
    gnome-keyring
    libsecret
    seahorse # GUI for gnome-keyring
    polkit_gnome # Authentication agent
  ];

  # # Enable gnome-keyring for secrets management
  # services.gnome.gnome-keyring.enable = true;
  # security.pam.services.gdm.enableGnomeKeyring = true;
  # security.pam.services.login.enableGnomeKeyring = true;

  # # Enable polkit authentication agent for Hyprland
  # security.polkit.enable = true;
  # systemd.user.services.polkit-gnome-authentication-agent-1 = {
  #   description = "polkit-gnome-authentication-agent-1";
  #   wantedBy = [ "graphical-session.target" ];
  #   wants = [ "graphical-session.target" ];
  #   after = [ "graphical-session.target" ];
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart =
  #       "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #     Restart = "on-failure";
  #     RestartSec = 1;
  #     TimeoutStopSec = 10;
  #   };
  # };
  #

  # Hardware acceleration and graphics driver support
  hardware.graphics = { enable = true; };
}

