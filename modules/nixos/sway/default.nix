{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services.kmscon = {
    enable = true;
    hwRender = true;
    fonts = [
      {
        name = "FiraCode";
        package = pkgs.fira-code;
      }
    ];
  };

  # Consider gtkgreet instead of tuigreet for GUI
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway --remember --asterisks --user-menu";
        user = "greeter";
      };
    };
  };

  # environment.systemPackages = with pkgs; [
  # 
  # ];

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
