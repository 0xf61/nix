{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Hostname configuration
  networking.hostName = "lap";

  # Host-specific configuration
  system.kanata.enable = false;
  services.blueman.enable = true;

  # Enable multiple desktop environments
  desktop.hyprland.enable = true;
  desktop.gnome.enable = true;
  desktop.defaultSession = "hyprland";

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

  # Hardware configuration for ThinkPad P1 Gen 5
  hardware = {
    nvidia = {
      prime = {
        offload.enable = true;
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:01:00:0";
      };
      open = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      modesetting.enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # Power management
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    };
  };
  services.power-profiles-daemon.enable = false;
  services.xserver.videoDrivers = [ "nvidia" ];
}