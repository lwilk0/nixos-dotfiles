{ config, lib, ... }:
let
  mod = "SUPER";
  modShift = "SUPER SHIFT";
  modControl = "SUPER CTRL";

  terminal = "kitty";
  file-manager = "kitty -- yazi-themed";
  browser = "brave";
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Window Shortcuts
      "${mod}, return, exec, ${terminal}"
      "${mod}, space, exec, caelestia shell drawers toggle launcher"      
      "${mod}, W, exec, ${browser}"
      "${mod}, E, exec, ${file-manager}"
      "${mod}, B, exec, blueman-manager"
      
      # Window Manager
      "${mod}, Q, killactive"
      "${mod}, M, exit"
      "${mod}, F, fullscreen"
      "${mod}, P, exec, pseudo"
 
      # Resize with Keyboard
      "${modControl}, left, resizeactive, -20 0"
      "${modControl}, right, resizeactive, 20 0"
      "${modControl}, up, resizeactive, 0 -20"
      "${modControl}, down, resizeactive, 0 20"
 
      # Move Focus with Keyboard
      "${mod}, left, movefocus, l"
      "${mod}, right, movefocus, r"
      "${mod}, up, movefocus, u"
      "${mod}, down, movefocus, d"

      # Switch Workspace
      "${mod}, 1, workspace, 1"
      "${mod}, 2, workspace, 2"
      "${mod}, 3, workspace, 3"
      "${mod}, 4, workspace, 4"
      "${mod}, 5, workspace, 5"
      "${mod}, 6, workspace, 6"
      "${mod}, 7, workspace, 7"
      "${mod}, 8, workspace, 8"
      "${mod}, 9, workspace, 9"
      "${mod}, 0, workspace, 10"

      # Move Active Window
      "${modShift}, 1, movetoworkspace, 1"
      "${modShift}, 2, movetoworkspace, 2"
      "${modShift}, 3, movetoworkspace, 3"
      "${modShift}, 4, movetoworkspace, 4"
      "${modShift}, 5, movetoworkspace, 5"
      "${modShift}, 6, movetoworkspace, 6"
      "${modShift}, 7, movetoworkspace, 7"
      "${modShift}, 8, movetoworkspace, 8"
      "${modShift}, 9, movetoworkspace, 9"
      "${modShift}, 0, movetoworkspace, 10"
    ];
    
    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];
  };
}
