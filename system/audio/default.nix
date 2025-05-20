{ pkgs, ... }: {
  # Enable sound with pipewire.

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    package = pkgs.bluez5-experimental;
  };
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

}
