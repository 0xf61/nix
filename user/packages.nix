{ pkgs, ... }:
let inherit (builtins) attrValues;
in {
  environment.systemPackages = attrValues {
    inherit (pkgs)
    # CLI tools & utilities
      aria2 atuin btop cifs-utils copyq dig docker-buildx fd fzf git gnumake jq
      lazygit neofetch nixd nil nmap qrencode rclone restic ripgrep rsync tmux
      unzip xh yazi

      # Development tools
      cargo clang gcc go lua luarocks nodejs_24 python3

      # GUI applications
      brave imv kitty mpv mullvad-browser neovim signal-desktop vesktop
      zed-editor-fhs;

    # Note: The following packages are removed because they're already defined in system modules:
    # - hyprlock, hyprpaper, hyprshot, mako, waybar, wl-clipboard, wofi (in desktop/hyprland.nix)
    # - fish (defined via programs.fish.enable = true)
  };
}
