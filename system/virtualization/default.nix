{ ... }: {

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
}
