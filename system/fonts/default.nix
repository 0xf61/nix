{ pkgs, ... }: {
  fonts.packages = with pkgs; [ nerd-fonts.hack ];
  environment.sessionVariables.FREETYPE_PROPERTIES =
    "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
}
