{ pkgs, ... }:

{
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
}
