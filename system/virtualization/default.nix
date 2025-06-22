{ ... }: {
  # Enable common container config files in /etc/containers
  virtualisation = {
    containers.enable = true;
    docker.enable = true;
    virtualbox = {
      host.enable = true;
      host.enableExtensionPack = true;
      #guest.enable = true;
      #guest.clipboard = true;
      #guest.vboxsf = true;
      #guest.dragAndDrop = true;
    };
  };
}
