#!/usr/bin/env bash
set -euo pipefail

nix flake update && nixos-rebuild switch --flake .#home-desktop --sudo