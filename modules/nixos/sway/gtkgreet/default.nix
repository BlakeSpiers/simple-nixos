{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --config /etc/sway/greeter.config";
        user = "greeter";
      };
    };
  };

  # env GTK_THEME=Adwaita:dark

  environment.etc."sway/greeter.config" = {
    text = ''
      # Set gtkgreet theme and start gtkgreet
      exec "${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; swaymsg exit"
      # Define a keybinding to power off or reboot from the greeter
      bindsym Mod4+shift+e exec ${pkgs.sway}/bin/swaynag \
        -t warning \
        -m 'What do you want to do?' \
        -b 'Poweroff' 'systemctl poweroff' \
        -b 'Reboot' 'systemctl reboot'
      # Default sway config includes
      include /etc/sway/config.d/*
    '';
  };

  # Define the sessions that gtkgreet will offer
  environment.etc."greetd/environments".text = ''
    sway
  '';

  # environment.etc."greetd/gtkgreet.css".text = ''
  #   window {
  #     background-color: #1e1e2e;
  #     color: #ffffff;
  #     font-family: "Fira Sans", sans-serif;
  #     font-size: 16px;
  #     scale: 1.5;
  #   }

  #   button {
  #     background-color: #3b4252;
  #     color: #ffffff;
  #     border-radius: 6px;
  #     padding: 6px 12px;
  #   }

  #   button:hover {
  #     background-color: #4c566a;
  #   }

  #   entry {
  #     background-color: #2e3440;
  #     color: #ffffff;
  #     border: 1px solid #4c566a;
  #     padding: 4px;
  #     border-radius: 4px;
  #   }
  # '';
}
