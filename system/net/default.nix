{ ... }: {
  networking = {
    # Network management
    networkmanager = {
      enable = true;
      unmanaged = [ "docker0" "rndis0" ];
      wifi = {
        macAddress = "random";
        powersave = true;
      };
    };

    # IPv6 enabled for netbird
    enableIPv6 = true;

    # DNS servers
    nameservers = [ "94.140.14.14" "94.140.14.15" ];

    # Firewall configuration
    firewall = {
      enable = false;
      trustedInterfaces = [ "zth6rnw6il" ];
      allowPing = false;
      logReversePathDrops = true;
    };
  };
}
