{...}: {
  wayland.windowManager.hyprland.settings = {
    # ── General ────────────────────────────────────────────────────────────────
    general = {
      gaps_in = 5;
      gaps_out = 5;
      border_size = 2;
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
      resize_on_border = false;
      allow_tearing = false; # per-window tearing is controlled via windowrulev2 "immediate"
      layout = "dwindle";
    };

    # ── Decoration ─────────────────────────────────────────────────────────────
    decoration = {
      rounding = 15;

      blur = {
        enabled = true;
        size = 7;
        passes = 4;
        new_optimizations = true;
        xray = false; # don't blur through layered surfaces (e.g. bars)
        ignore_opacity = false;
      };

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        "color" = "rgba(1a1a1aee)";
      };

      # Slightly dim inactive windows so focus is always obvious
      dim_inactive = true;
      dim_strength = 0.02;
    };

    # ── Animations ─────────────────────────────────────────────────────────────
    animations = {
      enabled = true;

      bezier = [
        "easeOutQuint,    0.23, 1,    0.32, 1"
        "easeInOutCubic,  0.65, 0.05, 0.36, 1"
        "linear,          0,    0,    1,    1"
        "almostLinear,    0.5,  0.5,  0.75, 1"
        "quick,           0.15, 0,    0.1,  1"
      ];

      animation = [
        "global,         1, 10,   default"
        "border,         1,  5.39, easeOutQuint"
        "windows,        1,  5.39, easeOutQuint"
        "windowsIn,      1,  4.1,  easeOutQuint, popin 87%"
        "windowsOut,     1,  1.49, linear,       popin 87%"
        "fadeIn,         1,  1.73, almostLinear"
        "fadeOut,        1,  1.46, almostLinear"
        "fade,           1,  3.03, quick"
        "layers,         1,  3.81, easeOutQuint"
        "layersIn,       1,  4,    easeOutQuint, fade"
        "layersOut,      1,  1.5,  linear,       fade"
        "fadeLayersIn,   1,  1.79, almostLinear"
        "fadeLayersOut,  1,  1.39, almostLinear"
        "workspaces,     1,  1.94, almostLinear, fade"
        "workspacesIn,   1,  1.21, almostLinear, fade"
        "workspacesOut,  1,  1.94, almostLinear, fade"
      ];
    };

    # ── Input ──────────────────────────────────────────────────────────────────
    input = {
      kb_layout = "gb";
      follow_mouse = 1; # focus follows mouse, but don't warp cursor on focus change
      sensitivity = 0; # 0 = no pointer acceleration
      accel_profile = "flat"; # flat accel — essential for gaming / precise guitar UI clicks
    };

    # ── Dwindle layout ─────────────────────────────────────────────────────────
    dwindle = {
      pseudotile = true; # SUPER+P toggles pseudo-tiling
      preserve_split = true; # split direction is remembered per-node
      smart_split = false;
    };

    # ── Miscellaneous ──────────────────────────────────────────────────────────
    misc = {
      # Variable frame rate: when nothing is moving Hyprland drops the
      # render rate significantly, saving GPU power/heat between tasks
      # (important when your GPU is also running audio plugins via yabridge).
      # vfr = true;

      # Remove the Hyprland branding from the empty-desktop background.
      disable_hyprland_logo = true;
      disable_splash_rendering = true;

      # Don't animate the workspace when the last window on it is closed.
      animate_manual_resizes = false;
      animate_mouse_windowdragging = false;

      # Focus the window under the cursor when switching workspaces
      # — prevents accidentally typing into the wrong app after a SUPER+N jump.
      focus_on_activate = false;

      # Keep the mouse cursor from jumping when a new window spawns
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
    };

    # ── Cursor ─────────────────────────────────────────────────────────────────
    cursor = {
      # Hide the cursor after 3 s of inactivity — useful during guitar / recording sessions
      inactive_timeout = 3;
      no_hardware_cursors = false;
    };
  };
}
