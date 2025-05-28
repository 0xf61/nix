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

  # Desktop environment and window manager settings moved to system/desktop modules

  # Enable ZerotierOne
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "ebe7fbd44520ad4e" "e4da7455b2bf31b4" ];
  };

  # Disable CUPS to print documents.
  services.printing.enable = false;

  # OpenSSH daemon is configured per-host in the host-specific configuration files
}
