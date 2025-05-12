# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "eqr"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Enable networking
    networkmanager.enable = true;
    # Who needs IPv6 / me for netbird :(
    enableIPv6 = true;

    nameservers = [ "94.140.14.14" "94.140.14.15" ];

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;
    firewall.trustedInterfaces = [ "zth6rnw6il" ];

  };

  nix = {
    optimise = {
      automatic = true;
      dates = [ "13:37" ];
    };

    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings.trusted-users = [ "root" "user" ];

  };

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

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
  };

  fonts.packages = with pkgs; [ nerd-fonts.hack ];

  security.rtkit.enable = true;

  # List services that you want to enable:
  services = {
    # Resolved
    resolved = {
      enable = true;
      domains = [ "~." ];
      dnssec = "false";
      dnsovertls = "false";
      # fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    };

    libinput.enable = true;

    # Netbird
    netbird = {
      enable = true;
      server.domain = "https://guf.n3rv.org";
    };

    # Udev
    udev.packages = [ pkgs.yubikey-personalization ];

    # Enable the X11 windowing system.
    xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    xserver = {
      displayManager.gdm.enable = true;
      # desktopManager.gnome.enable = true;
    };

    # Configure keymap in X11
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Enable ZerotierOne
    zerotierone = {
      enable = true;
      joinNetworks = [ "ebe7fbd44520ad4e" "e4da7455b2bf31b4" ];
    };

    # Disable CUPS to print documents.
    printing.enable = false;

    # Mullvad Daemon
    # mullvad-vpn.enable = true;

    # Enable sound with pipewire.
    # hardware.pulseaudio.enable = false;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      listenAddresses = [{
        addr = "192.168.193.6";
        port = 22;
      }];
    };
  };

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
    # steam = {
    #   enable = true;
    #   remotePlay.openFirewall =
    #     true; # Open ports in the firewall for Steam Remote Play
    #   dedicatedServer.openFirewall =
    #     true; # Open ports in the firewall for Source Dedicated Server
    #   localNetworkGameTransfers.openFirewall =
    #     true; # Open ports in the firewall for Steam Local Network Game Transfers
    # };

  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" ];
    packages = with pkgs; [ vesktop nixpkgs-review gh ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable common container config files in /etc/containers
  virtualisation = {
    containers.enable = true;
    docker = { enable = true; };
    virtualbox = {
      host.enable = true;
      guest.enable = true;
      guest.dragAndDrop = true;
    };
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    aria2
    atuin
    brave
    btop
    cifs-utils
    cliphist
    dig
    docker-buildx
    fd
    fzf
    gcc
    git
    go
    hyprlock
    hyprpaper
    hyprshot
    keepassxc
    kitty
    lazygit
    lua
    luarocks
    mako
    mullvad-browser
    # mullvad-vpn
    neofetch
    neovim-unwrapped
    nodejs_24
    obsidian
    python3
    rclone
    restic
    ripgrep
    signal-desktop-bin
    telegram-desktop
    tmux
    unzip
    waybar
    wl-clipboard
    wofi
    yazi
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system = {
    stateVersion = config.system.nixos.release; # Did you read the comment?
    autoUpgrade.enable = true;
  };

}
