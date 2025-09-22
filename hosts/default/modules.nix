{ config, lib, pkgs, ...}: {
  imports = [
    ../../modules/nixos/gnome
    ../../modules/nixos/sway
  ];
}
