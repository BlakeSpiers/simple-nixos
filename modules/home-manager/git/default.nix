{ config, pkgs, osConfig, ... }: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "Blake Spiers";
      user.email = "blakespiers93@gmail.com";
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };
}
