{ config, pkgs, osConfig, ... }: {
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
      config = {
        warn_timeout = "30s";
      };
    };

    bash = {
      enable = true;
      shellAliases = {
        ll = "ls -la";
      };
    };
  };
}
