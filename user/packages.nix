{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # System utilities
    btop
    neofetch
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
    copyq
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
    kitty
    neovim
    nixd
    nil

    # GUI applications
    brave
    imv
    mpv
    mullvad-browser
    signal-desktop
    vesktop
    zed-editor-fhs

    # Utilities
    cifs-utils
    docker-buildx
  ];
}