{ config, pkgs, osConfig, ... }:
  let
    # HDMI-A-2: 4K monitor (3840x2160) at 1.5x scale
    hdmiA2 = {
      width = 3840;
      height = 2160;
      scale = 1.5;
    };

    # HDMI-A-1: 1080p monitor (1920x1080) at 1.0x scale
    hdmiA1 = {
      width = 1920;
      height = 1080;
      scale = 1.0;
    };

    # Round to nearest integer
    round = n: builtins.floor (n+ 0.5);

    # Helper: calculates logical dimensions
    logical = monitor: {
      width = monitor.width / monitor.scale;
      height = monitor.height / monitor.scale;
    };

    # Function to center-align vertically
    centerAlign = primary: secondary: 
      let
        lp = logical primary;
        ls = logical secondary;
      in {
      x = round lp.width;
      y = round ((lp.height - ls.height) / 2);
    };

    # Use the function
    posA2 = "0 0"; # Primary at top-left
    posA1Result = centerAlign hdmiA2 hdmiA1;
    posA1 = "${builtins.toString posA1Result.x} ${builtins.toString posA1Result.y}";
  in {

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
        # Primary display
        HDMI-A-2 = {
          scale = builtins.toString hdmiA2.scale;
          pos = posA2;
        };

        HDMI-A-1 = {
          scale = builtins.toString hdmiA1.scale;
          pos = posA1;
          # pos = "2560 0"; # 3840/1.5
        };
      };

      # What do workspaces do?
      # config.workspaceOutput = {
      #   "1" = "HDMI-A-2";
      #   "2" = "HDMI-A-1";
      # };

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
