{ config, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # 32-bit support for Steam/Wine if needed
  };

  # Despite the "xserver" name, this is how NixOS loads NVIDIA drivers system-wide,
  # including for Wayland compositors like Sway.
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Required for Wayland compositors (Sway, Hyprland, etc.)
    modesetting.enable = true;

    # RTX 3060 is Ampere (GA106), which fully supports NVIDIA's open kernel modules.
    # If you get kernel build failures, set this to false to use the proprietary blob modules.
    open = true;

    # Provides the nvidia-settings GUI for diagnostics and configuration.
    nvidiaSettings = true;

    # Helps avoid issues with suspend/resume on desktop systems.
    powerManagement.enable = true;

    # Use the stable driver. Alternatives if you hit issues:
    #   config.boot.kernelPackages.nvidiaPackages.production
    #   config.boot.kernelPackages.nvidiaPackages.beta
    #   config.boot.kernelPackages.nvidiaPackages.latest
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.sessionVariables = {
    # Vulkan renderer generally works better than GLES on NVIDIA + wlroots.
    # If you see screen flickering or rendering issues, try removing this
    # or switching to "gles2".
    WLR_RENDERER = "vulkan";

    # Tell GBM and GLX to use the NVIDIA driver for buffer allocation.
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    # Hardware cursor planes often cause invisible or flickering cursors on
    # NVIDIA + wlroots. Disable them. You can try removing this after driver
    # updates to see if the issue has been fixed upstream.
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Enables DRM kernel mode setting at boot — critical for Wayland.
  # This merges with any existing boot.kernelParams in configuration.nix.
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # TROUBLESHOOTING:
  #
  # Monitor names changed after enabling NVIDIA:
  #   NVIDIA DRM may expose different connector names than the Intel iGPU did.
  #   Run: swaymsg -t get_outputs
  #   Then update output names in modules/home-manager/sway/default.nix
  #
  # nvidia-smi shows the GPU but displays are blank/wrong:
  #   Check that boot.kernelParams includes nvidia-drm.modeset=1
  #   Verify with: cat /proc/cmdline
  #
  # No NVIDIA modules loaded after rebuild:
  #   Reboot is required after first enabling NVIDIA drivers.
  #   Verify with: lsmod | grep nvidia
}
