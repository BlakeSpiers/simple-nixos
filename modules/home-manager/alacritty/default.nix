{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 4;
          y = 4;
        };
      };
      font = {
        size = 12.0;
      };
    };
  };
}
