{ ... }: {
  imports = [ ./packages.nix ];
  
  programs.direnv = {
    enable = false;
    enableFishIntegration = false;
  };
  programs.fish.enable = true;
}