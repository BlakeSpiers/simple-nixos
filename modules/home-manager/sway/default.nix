{ config, pkgs, osConfig, ... }: {
  home.packages = with pkgs; [
    swaylock
    swayidle
    wl-clipboard
    wdisplays
    wlogout
    wofi

    # audio controls
    pamixer
    playerctl
    wob
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      # modifier = "Mod4";
      # terminal = "kitty";
      startup = [
        {command = "code";}
        {command = "firefox";}
        {command = "swayidle -w"; always = true;}
        {command = "rm -f ~/.wobpipe && mkfifo ~/.wobpipe && tail -f ~/.wobpipe | wob &";}
      ];

      output = {
        HDMI-A-2 = {
          scale = "1.5";
        };
      };

      keybindings = {
        # Decrease volume
        "XF86AudioLowerVolume" = "exec pamixer -d 5 && pamixer --get-volume | tee ~/.wobpipe > /dev/null";

        # Increase volume
        "XF86AudioRaiseVolume" = "exec pamixer -i 5 && pamixer --get-volume | tee ~/.wobpipe > /dev/null";

        # Mute toggle (show 0 or 100 accordingly)
        "XF86AudioMute" = "exec pamixer -t && (pamixer --get-mute | grep true && echo 0 || pamixer --get-volume) | tee ~/.wobpipe > /dev/null";

        # Media control (optional)
        "XF86AudioPlay"  = "exec playerctl play-pause";
        "XF86AudioNext"  = "exec playerctl next";
        "XF86AudioPrev"  = "exec playerctl previous";
      };
    };
  };  
}
