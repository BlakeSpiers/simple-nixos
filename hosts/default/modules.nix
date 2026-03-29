{ config, lib, pkgs, ...}: {
  imports = [
    ../../modules/nixos/gnome
    ../../modules/nixos/nvidia
    ../../modules/nixos/sway
  ];
}
