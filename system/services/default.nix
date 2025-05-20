{ pkgs, ... }: {
  # Resolved
  services.resolved = {
    enable = true;
    domains = [ "~." ];
    dnssec = "false";
    dnsovertls = "false";
    # fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  services.libinput.enable = true;

  # Netbird
  services.netbird = {
    enable = true;
    server.domain = "https://guf.n3rv.org";
  };

  # Udev
  services.udev.packages = [ pkgs.yubikey-personalization ];

  services.displayManager.defaultSession = "hyprland-uwsm";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.xterm.enable = false;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu # application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock # default i3 screen locker
      ];
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable ZerotierOne
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "ebe7fbd44520ad4e" "e4da7455b2bf31b4" ];
  };

  # Disable CUPS to print documents.
  services.printing.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    listenAddresses = [{
      addr = "192.168.193.6";
      port = 22;
    }];
  };
}
