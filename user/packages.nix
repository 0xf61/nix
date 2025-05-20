{ pkgs, ... }:
let inherit (builtins) attrValues;
in {
  environment.systemPackages = attrValues {
    inherit (pkgs)
      aria2 atuin brave btop cargo cifs-utils clang copyq dig docker-buildx fd
      fzf gcc git gnumake go hyprlock hyprpaper hyprshot imv jq keepassxc kitty
      lazygit lua luarocks mako mpv mullvad-browser neofetch neovim nmap
      nodejs_24 python3 qrencode rclone restic ripgrep rsync signal-desktop tmux
      unzip vesktop waybar wl-clipboard wofi xh yazi fish;
  };
}
