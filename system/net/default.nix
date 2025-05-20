{ ... }: {
  networking = {

    # Enable networking
    networkmanager = {
      enable = true;
      unmanaged = [ "docker0" "rndis0" ];
      wifi = {
        macAddress = "random";
        powersave = true;
      };
    };

    # Who needs IPv6 / me for netbird :(
    enableIPv6 = true;

    nameservers = [ "94.140.14.14" "94.140.14.15" ];

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;
    firewall.trustedInterfaces = [ "zth6rnw6il" ];
    firewall = {
      allowPing = false;
      logReversePathDrops = true;
    };

  };
}
