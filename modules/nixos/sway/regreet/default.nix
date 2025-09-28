{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      # default greeter session: run ReGreet, then Sway
      default_session = {
        # This command should run ReGreet, then start Sway
        command = lib.mkForce ''
          ${pkgs.regreet}/bin/regreet; \
          ${pkgs.sway}/bin/sway
        '';
        # optionally user for greeter or default session
        user = "greeter";
      };
      # optional: autologin / initial_session if desired
      # initial_session = { command = "${pkgs.sway}/bin/sway"; user = "youruser"; };
    };
  };

  programs.regreet = {
    enable = true;
    # optional theming / CSS etc
    extraCss = '' 
      /* custom CSS rules */
    '';
    # optional ReGreet settings (regreet.toml contents)
    settings = {
      # e.g. theme = "Adwaita";
      # background = "/path/to/image.png";
      # etc. See ReGreet sample for all options :contentReference[oaicite:3]{index=3}
    };
    # optional: extra args to cage if using cage wrapper
    cageArgs = [ "-s" ];  # example if you want VT switching etc :contentReference[oaicite:4]{index=4}
  };
}