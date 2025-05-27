{ config, pkgs, lib, ... }: {
  imports = [
    ./audio
    ./boot
    ./fonts
    ./net
    ./nix
    ./programs
    ./security
    ./services
    ./users
    ./virtualization
    ./kanata
  ];

  module1.enable = true;

  environment.etc.machine-id.text = "b08dfa6083e7567a1921a715000001fb";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.pathsToLink =
    [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

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
