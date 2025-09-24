{
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    xserver = {
      enable = true;

      # layout = "au";
      # xkbVariant = "";

      xkb = {
        layout = "us";
        variant = ""; 
      };
    };
  };
}