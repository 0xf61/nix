{ pkgs, ... }: {
  # Enable common container config files in /etc/containers
  virtualisation = {
    containers.enable = true;
    docker.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  # Add virt-manager to system packages
  environment.systemPackages = with pkgs; [
    virt-manager
  ];
}
