{ lib, ... }: {
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

  services.blueman.enable = true;

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
      # Enable NVIDIA driver with PRIME render offload
      prime = {
        offload.enable = true;
        # Intel iGPU
        intelBusId = "PCI:00:02:0";
        # NVIDIA GPU
        nvidiaBusId = "PCI:01:00:0";
      };
      # # Use the latest NVIDIA driver
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      open = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      modesetting.enable = true;
    };
    # Enable OpenGL support
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    # Enable CPU frequency scaling
    cpu.intel.updateMicrocode = true;
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
  # Explicitly disable power-profiles-daemon to avoid conflict with TLP
  services.power-profiles-daemon.enable = false;

  services.xserver.videoDrivers = [ "nvidia" ];

  # # Enable hardware video acceleration
  # nixpkgs.config.packageOverrides = pkgs: {
  #   vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  # };

}
