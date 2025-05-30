{ pkgs, ... }: {
  # DNS resolution
  services.resolved = {
    enable = true;
    domains = [ "~." ];
    dnssec = "false";
    dnsovertls = "false";
  };

  # Input devices
  services.libinput.enable = true;

  # VPN services
  services.netbird = {
    enable = true;
    server.domain = "https://guf.n3rv.org";
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "ebe7fbd44520ad4e" "e4da7455b2bf31b4" ];
  };

  # Hardware support
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # Disabled services
  services.printing.enable = false;
}
