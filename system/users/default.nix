{ pkgs, ... }: {
  users = {
    users.user = {
      isNormalUser = true;
      description = "user";
      shell = pkgs.fish;
      uid = 1000;
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
        "uinput"
        "vboxusers"
        "video"
        "wheel"
        "wireshark"
      ];
      packages = with pkgs; [ vesktop nixpkgs-review gh xorg.xhost ];
    };
  };


}

