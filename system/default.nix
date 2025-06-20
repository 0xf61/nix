{ pkgs, lib, ... }: {
  imports = [
    ./boot
    ./desktop
    ./kanata
    ./media
    ./net
    ./nix
    ./security
    ./virtualization
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "google-chrome"
  ];

  desktop.enable = true;

  environment = {
    etc.machine-id.text = "b08dfa6083e7567a1921a715000001fb";
    pathsToLink = [ "/libexec" ];
    sessionVariables = {
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
      SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";
    };
  };

  time.timeZone = "Europe/Istanbul";

  i18n.defaultLocale = "en_US.UTF-8";

  # Programs
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    ssh.startAgent = false;
    fish.enable = true;
  };

  # Services (merged from ./services)
  services = {
    resolved = {
      enable = true;
      domains = [ "~." ];
      dnssec = "false";
      dnsovertls = "false";
    };
    netbird = {
      enable = true;
      server.domain = "https://guf.n3rv.org";
    };
    zerotierone = {
      enable = true;
      joinNetworks = [ "ebe7fbd44520ad4e" "e4da7455b2bf31b4" ];
    };
    udev.packages = [ pkgs.yubikey-personalization ];
    printing.enable = false;
  };

  # Users (merged from ./users)
  users.users.user = {
    isNormalUser = true;
    description = "user";
    shell = pkgs.fish;
    uid = 1000;
    extraGroups = [
      "adbusers"
      "audio"
      "docker"
      "input"
      "lp"
      "networkmanager"
      "nix"
      "plugdev"
      "power"
      "systemd-journal"
      "uinput"
      "vboxusers"
      "video"
      "wheel"
      "wireshark"
    ];
    packages = with pkgs; [ nixpkgs-review ];
  };

  system.autoUpgrade.enable = true;
  system.stateVersion = "24.05";
}