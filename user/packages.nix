{ config, lib, pkgs, ... }: {
  programs.fish.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    font-awesome
  ];

  environment.systemPackages = with pkgs; [
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
    gcc
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
    nixd
    nil

    # Cross-platform GUI applications
    alacritty
    brave
    firefox
    mpv
    kitty
    google-chrome

    # Utilities
    docker-buildx
    gh
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    raycast
    iterm2
    vscode
    discord
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    cifs-utils
    copyq
    imv
    mullvad-browser
    signal-desktop
    vesktop
    xorg.xhost
    zed-editor-fhs
  ];
}
