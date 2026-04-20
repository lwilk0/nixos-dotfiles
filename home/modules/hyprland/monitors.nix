{ config, lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Syntax: monitor=name,resolution,position,scale
    monitor = [
      "HDMI-A-6,1920x1080@75,0x0,1"
      "DP-1,1920x1080@60,1920x0,1"
    ];
  };
}
