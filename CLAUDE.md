# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
./rebuild.sh                # Rebuild and switch to current config
./update.sh                 # Update flake inputs then rebuild
./cleanup.sh                # Remove old generations (keeps 3)
```

Underlying commands:
- **Rebuild:** `nixos-rebuild switch --flake .#home-desktop --sudo`
- **Update + rebuild:** `nix flake update && nixos-rebuild switch --flake .#home-desktop --sudo`
- **Fresh install from remote:** `nixos-rebuild switch --flake github:blakespiers/nix-config#HOST --sudo`

## Architecture

This is a NixOS flake configuration for a single host (`home-desktop`, x86_64-linux) running Sway on Wayland with Home Manager for user-level config.

### Flake structure

`flake.nix` takes two inputs (nixpkgs unstable + home-manager) and defines one NixOS configuration. The `inputs` are passed via `specialArgs` so all modules can access them.

### Configuration layers

**System-level** (`hosts/default/configuration.nix`):
- Imports `hardware-configuration.nix` (auto-generated, don't edit by hand), `modules.nix`, and Home Manager
- Configures boot, networking, locale, PipeWire audio, user account (`blake`), and system packages
- `modules.nix` imports system modules from `modules/nixos/` (currently gnome + sway)

**User-level** (`hosts/default/home.nix`):
- Home Manager entry point; imports user modules from `modules/home-manager/`
- User packages (firefox, vscode, claude-code, etc.) and session variables live here

### Module layout

| Path | Purpose |
|------|---------|
| `modules/nixos/sway/` | Sway WM system config + greeter (tuigreet is active; gtkgreet and regreet are alternatives) |
| `modules/nixos/gnome/` | GNOME/GDM config (imported but available as alternative) |
| `modules/home-manager/sway/` | Sway user config: multi-monitor layout, keybindings, startup apps, GTK theme |
| `modules/home-manager/git/` | Git user/email config |
| `modules/home-manager/direnv/` | direnv + nix-direnv + bash setup |

### How to extend

- **Add a system service:** Create `modules/nixos/<name>/default.nix`, import it in `hosts/default/modules.nix`
- **Add a user program/module:** Create `modules/home-manager/<name>/default.nix`, import it in `hosts/default/home.nix`
- **Add a user package:** Append to `home.packages` in `hosts/default/home.nix`
- **Add a system package:** Append to `environment.systemPackages` in `hosts/default/configuration.nix`

### Key details

- State versions are `25.05` for both NixOS and Home Manager
- nixpkgs tracks `nixos-unstable`
- `allowUnfree = true` is set in both system and Home Manager config
- The Sway home-manager module has multi-monitor math helpers and detailed output/workspace assignments
