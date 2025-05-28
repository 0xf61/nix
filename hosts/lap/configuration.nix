{ config, lib, pkgs, ... }: {
  # Explicitly disable kanata for lap
  system.kanata.enable = false;


  # Host-specific SSH configuration for lap
  services.openssh = {
    enable = true;
    listenAddresses = [{
      addr = "192.168.193.15";
      port = 22;
    }];
  };

  # Enable Steam on the laptop
  programs.steam = {
    enable = lib.mkForce true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
