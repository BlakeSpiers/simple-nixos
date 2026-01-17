#!/usr/bin/env bash
set -euo pipefail

nixos-rebuild switch --flake .#home-desktop --sudo