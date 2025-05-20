{ pkgs, ... }: {
  users = {
    users.user = {
      isNormalUser = true;
      description = "user";
      shell = pkgs.fish;
      uid = 1337;
      extraGroups = [
        "adbusers"
        "audio"
        "docker"
        "input"
        "lp"
        "networkmanager"
        "nix"
        "plugdev"
        "power"
        "systemd-journal"
        "vboxusers"
        "video"
        "wheel"
        "wireshark"
      ];
      packages = with pkgs; [ vesktop nixpkgs-review gh xorg.xhost ];
    };
  };

  # security = {
  #   sudo = {
  #     enable = true;
  #     extraRules = [{
  #       commands = builtins.map (command: {
  #         command = "/run/current-system/sw/bin/${command}";
  #         options = [ "NOPASSWD" ];
  #       }) [
  #         "poweroff"
  #         "reboot"
  #         "nixos-rebuild"
  #         "nix-env"
  #         "bandwhich"
  #         "systemctl"
  #       ];
  #       groups = [ "wheel" ];
  #     }];
  #   };
  #
  # };
}

