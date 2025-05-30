{ ... }: {
  programs = {
    # GPG agent for SSH authentication (Yubikey support)
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Disable default SSH agent
    ssh.startAgent = false;

    # Install firefox.
    firefox.enable = true;

    # Install fish
    fish.enable = true;
  };
}
