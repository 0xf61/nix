{ lib, pkgs, ... }: {
  programs.fish.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    font-awesome
  ];

  environment.systemPackages = with pkgs;
    [
      # System utilities
      btop
      fastfetch
      tmux
      unzip

      # Network tools
      aria2
      dig
      nmap
      rsync

      # Development tools
      cargo
      clang
      docker-buildx
      gcc
      gh
      git
      gnumake
      go
      lua
      luarocks
      nodejs_24
      python3

      # File management
      fd
      fzf
      jq
      lazygit
      qrencode
      rclone
      restic
      ripgrep
      xh
      yazi

      # Terminal & editors
      atuin
      neovim
      nil
      nixd
      nixfmt

      # Cross-platform GUI applications
      alacritty
      brave
      firefox
      google-chrome
      kitty
      mpv
   ] ++ lib.optionals pkgs.stdenv.isDarwin [ raycast vscode discord iterm2 ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      cifs-utils
      copyq
      imv
      mullvad-browser
      signal-desktop
      vesktop
      vscode-fhs
      xorg.xhost
      zed-editor-fhs
   ];
}
