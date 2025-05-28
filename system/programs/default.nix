{ lib, ... }: {
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

  };
}
