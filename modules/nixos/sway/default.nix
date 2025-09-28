{ pkgs, ... }:

{
  imports = [
    # ./gtkgreet
    # ./regreet
    ./tuigreet
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.xwayland.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}