{ config, lib, pkgs, ... }: {
  config = lib.mkIf (config.desktop.enable && config.desktop.session == "i3") {
    services.xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
        rofi
        dunst
        feh
        picom
        arandr
        xorg.xbacklight
        lxappearance
      ];

      # Additional configuration can be added here
      package = pkgs.i3;
    };

    # Add i3-specific dependencies
    environment.systemPackages = with pkgs; [
      # Screen locking
      xss-lock

      # Status bar utilities
      psmisc
      lm_sensors

      # Other utilities
      xclip
      scrot
      flameshot
      pavucontrol
    ];

    # This ensures proper font support in i3
    fonts.packages = with pkgs; [
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];
  };
}

