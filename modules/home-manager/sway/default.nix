{ config, pkgs, osConfig, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      # modifier = "Mod4";
      # terminal = "kitty";
      startup = [
        {command = "code";}
        {command = "firefox";}
      ];

      output = {
        HDMI-A-2 = {
          scale = "1.5";
        };
      };
    };
  };
}
