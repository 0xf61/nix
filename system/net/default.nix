{ ... }: {
  networking = {
    networkmanager = {
      enable = true;
      unmanaged = [ "docker0" "rndis0" ];
      wifi = {
        macAddress = "random";
        powersave = true;
      };
    };

    enableIPv6 = true;
    nameservers = [ "94.140.14.14" "94.140.14.15" ];

    firewall = {
      enable = false;
      trustedInterfaces = [ "zth6rnw6il" ];
      allowPing = false;
      logReversePathDrops = true;
    };
  };
}
