{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # ══════════════════════════════════════════════════════════════════════════
      # WORKSPACE ASSIGNMENTS
      # ══════════════════════════════════════════════════════════════════════════

      "workspace 1 silent, match:class ^(brave-browser|Brave-browser)$"
      "workspace 2 silent, match:class ^(dev.zed.Zed|zeditor)$"
      "workspace 3 silent, match:class ^(bitwig-studio|com.bitwig.BitwigStudio)$"
      "workspace 3 silent, match:class ^(carla|Carla)$"
      "workspace 3 silent, match:class ^(org.rncbc.qjackctl|QjackCtl)$"
      "workspace 4 silent, match:class ^(steam)$"
      "workspace 4 silent, match:class ^(steam_app_).*"
      "workspace 4 silent, match:class ^(lutris|heroic|bottles)$"
      "workspace 5 silent, match:class ^(discord|Discord)$"
      "workspace 5 silent, match:class ^(ferdium|Ferdium)$"
      "workspace 6 silent, match:class ^(obsidian|Obsidian)$"

      # ══════════════════════════════════════════════════════════════════════════
      # FLOATING WINDOWS
      # ══════════════════════════════════════════════════════════════════════════

      "float on, match:class ^(qjackctl|QjackCtl)$"
      "size 460 320, match:class ^(qjackctl|QjackCtl)$, match:title ^(QjackCtl)$"
      "center on, match:class ^(qjackctl|QjackCtl)$, match:title ^(QjackCtl)$"
      "float on, match:class ^(qjackctl|QjackCtl)$, match:title ^(Connections|Graph|Messages|Session|Patchbay).*"

      "float on, match:class ^(blueman-manager)$"
      "size 700 500, match:class ^(blueman-manager)$"
      "center on, match:class ^(blueman-manager)$"

      "float on, match:class ^(steam)$, match:title ^(Steam)$"
      "float on, match:class ^(steam)$, match:title ^(Friends).*"
      "float on, match:class ^(steam)$, match:title ^(Steam Guard).*"

      "float on, match:class ^(wine)$"
      "float on, match:title ^(Wine System Tray)$"

      "float on, match:title ^(Open File)$"
      "float on, match:title ^(Open Folder)$"
      "float on, match:title ^(Save As)$"
      "float on, match:title ^(File Upload)$"

      "float on, match:title ^(Picture-in-Picture)$"
      "size 640 360, match:title ^(Picture-in-Picture)$"
      "move 100%-650 50, match:title ^(Picture-in-Picture)$"

      # ══════════════════════════════════════════════════════════════════════════
      # GAMING — TEARING & PERFORMANCE
      # ══════════════════════════════════════════════════════════════════════════

      "immediate on, match:class ^(steam_app_).*"
      "immediate on, match:class ^(gamescope)$"
      "immediate on, match:fullscreen 1"
      "workspace 4, match:class ^(steam_app_).*"

      # ══════════════════════════════════════════════════════════════════════════
      # KITTY — TERMINAL TRANSPARENCY
      # ══════════════════════════════════════════════════════════════════════════

      "opacity 0.90 override 0.9o override, match:class ^(kitty)$"

      # ══════════════════════════════════════════════════════════════════════════
      # AUDIO APPS — NO IDLE INHIBIT
      # ══════════════════════════════════════════════════════════════════════════

      # "idleinhibit, match:class ^(bitwig-studio|com.bitwig.BitwigStudio)$"
      # "idleinhibit, match:class ^(carla|Carla)$"
      "suppress_event maximize, match:class ^(bitwig-studio|com.bitwig.BitwigStudio)$"

      # ══════════════════════════════════════════════════════════════════════════
      # MISCELLANEOUS
      # ══════════════════════════════════════════════════════════════════════════

      "suppress_event maximize, match:class ^(obsidian|Obsidian)$"
      "float on, match:class ^(qbittorrent)$, match:title ^(Add New Torrent).*"
      "float on, match:class ^(qbittorrent)$, match:title ^(Options)$"
      "suppress_event maximize, match:class ^(dev.zed.Zed|zeditor)$"
    ];
  };
}
