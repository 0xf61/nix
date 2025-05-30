{ config, ... }: {
  imports = [
    ./boot
    ./desktop
    ./environment
    ./kanata
    ./media
    ./net
    ./nix
    ./programs
    ./security
    ./services
    ./users
    ./virtualization
  ];

  # Enable desktop environment
  desktop.enable = true;
  desktop.defaultSession = "hyprland";
  desktop.hyprland.enable = true;

  environment.etc.machine-id.text = "b08dfa6083e7567a1921a715000001fb";

  time.timeZone = "Europe/Istanbul";
  security.rtkit.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  system = { autoUpgrade.enable = true; };
  system.stateVersion = config.system.nixos.release; # Did you read the comment?
}
