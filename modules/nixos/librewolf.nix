{ config, pkgs, ... }:

{
  # 1. Install the Wayland-specific wrapper of LibreWolf
  environment.systemPackages = with pkgs; [
    librewolf
  ];

  # 2. Force the hardware acceleration environment variables system-wide
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1"; # Critical for AMD video/hardware acceleration
    LIBVA_DRIVER_NAME = "radeonsi";
    EGL_PLATFORM = "wayland";
  };
}