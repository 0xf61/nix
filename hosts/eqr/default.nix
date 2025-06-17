{ lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Hostname configuration
  networking.hostName = "eqr";

  # Host-specific configuration
  system.kanata.enable = true;
  programs.steam.enable = lib.mkForce false;

  # Enable only Hyprland desktop environment
  desktop.hyprland.enable = true;
  desktop.gnome.enable = false;
  desktop.defaultSession = "hyprland";

  services.openssh = {
    enable = true;
    listenAddresses = [{
      addr = "192.168.193.6";
      port = 22;
    }];
  };
}
