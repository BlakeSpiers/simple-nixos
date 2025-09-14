{
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # layout = "au";
      # xkbVariant = "";

      xkb = {
        layout = "us";
        variant = ""; 
      };
    };
  };
}