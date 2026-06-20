{ config, lib, pkgs, ... }:

let
  swayCmd = "sway" + lib.optionalString (builtins.elem "nvidia" config.services.xserver.videoDrivers) " --unsupported-gpu";
in
{
  fonts.packages = [ pkgs.fira-code ];

  services.kmscon = {
    enable = true;
    config = {
      hwaccel = true;
      font-name = "Fira Code";
    };
  };

  # Consider gtkgreet instead of tuigreet for GUI
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd \"${swayCmd}\" --remember --asterisks --user-menu";
        user = "greeter";
      };
    };
  };
}
