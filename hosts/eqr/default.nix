{ lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Hostname configuration
  networking.hostName = "eqr";

  # Host-specific configuration
  programs.steam.enable = lib.mkForce false;

  # Enable only Gnome desktop environment
  desktop.gnome.enable = true;
  desktop.defaultSession = "gnome";

  services.openssh = {
    enable = true;
    listenAddresses = [{
      addr = "192.168.193.6";
      port = 22;
    }];
  };

  services.kasmweb = {
    enable = true;
    listenPort = 1337;
    listenAddress = "192.168.193.6";
  };
}
