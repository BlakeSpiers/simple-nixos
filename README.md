# nix-config

To update flake dependencies:
`nix flake update`

To rebuild the flake for home-desktop:
`nixos-rebuild switch --flake .#home-desktop --sudo`

To do both:
`nix flake update && nixos-rebuild switch --flake .#home-desktop --sudo`

## Fresh Install
Run:
`nixos-rebuild switch --flake github:blakespiers/nix-config#HOST --sudo`

If you encounter `systemd-boot not installed in ESP.`, run:
`sudo bootctl install`

Reboot and repeat the rebuild step.

## Cleanup

Delete all old generations:
`nix-collect-garbage -d`

Delete generations older than 10 days:
`nix-collect-garbage -d --delete-older-than 10d`

Alternatively, use the nh command from nixpkgs for more control:
`nh clean all --keep 3`