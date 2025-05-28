{ config, lib, pkgs, ... }: {
  # Central place for all environment variables
  environment = {
    # Path configuration
    pathsToLink = [
      "/libexec" # Links /libexec from derivations to /run/current-system/sw
    ];

    # General environment variables
    sessionVariables = {
      # For Wayland applications
      NIXOS_OZONE_WL = "1";

      # For applications using SDL to prefer Wayland
      SDL_VIDEODRIVER = "wayland";

      # For Qt applications
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      # For ElementaryOS/Pantheon applications
      CLUTTER_BACKEND = "wayland";

      # For XDG Desktop Portal
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";

      # Font rendering
      FREETYPE_PROPERTIES =
        "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
    };
  };
}

