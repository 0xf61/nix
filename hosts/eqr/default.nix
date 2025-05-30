{ lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Host-specific configuration
  system.kanata.enable = true;
  programs.steam.enable = lib.mkForce false;

  services.openssh = {
    enable = true;
    listenAddresses = [{
      addr = "192.168.193.6";
      port = 22;
    }];
  };
}