{ config, lib, pkgs, ... }: {
  # Enable kanata keyboard remapping service specifically for eqr
  system.kanata.enable = true;

  # Host-specific SSH configuration for eqr
  services.openssh = {
    enable = true;
    listenAddresses = [{
      addr = "192.168.193.6";
      port = 22;
    }];
  };

  # Explicitly disable Steam on eqr
  programs.steam.enable = lib.mkForce false;
}
