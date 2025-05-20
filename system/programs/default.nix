{ lib, ... }: {
  programs = {
    # GNUPG
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Install firefox.
    firefox.enable = true;

    # Install fish
    fish.enable = true;

    # Install Hyprland
    hyprland.enable = true;

    # Steam
    steam = {
      enable = lib.mkDefault false;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall =
        true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

  };

}
