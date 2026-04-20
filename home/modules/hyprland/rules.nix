{ config, lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Float Specific Apps
      # "float on, match:class ^(pavucontrol)$"
      # "float on, match:class ^(nc-connection-editor)$"
      "opacity 0.8 override 0.8 override, class:^(kitty)$"
      "blur, class:^(kitty)$"
      "ignorealpha 0.7, class:^(kitty)$"
  
      # Size Specific
      # "size on, 800 600 match:class ^(pavucontrol)$"

      # Ignore Maximize Requests For Specific Dialogs
      # "suppressevent maximize, match:class ^(.*))$"
    ];
  };
}
