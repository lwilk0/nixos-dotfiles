{...}: {
  xdg.configFile."hypr/settings.lua".text = ''
    -- ── General ────────────────────────────────────────────────────────────────
    hl.config({
      general = {
        gaps_in   = 5,
        gaps_out  = 5,
        border_size = 2,
        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
      },

      -- ── Decoration ─────────────────────────────────────────────────────────────
      decoration = {
        rounding = 15,

        blur = {
            enabled            = true,
            size               = 7,
            passes             = 4,
            new_optimizations  = true,
            xray               = false,
            ignore_opacity     = false,
        },

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        dim_inactive = true,
        dim_strength = 0.02,
      },

      -- ── Animations ─────────────────────────────────────────────────────────────
      animations = {
          enabled = true,
      },

      -- ── Input ──────────────────────────────────────────────────────────────────
      input = {
          kb_layout     = "gb",
          follow_mouse  = 1,
          sensitivity   = 0,
          accel_profile = "flat",
      },

      -- ── Dwindle layout ─────────────────────────────────────────────────────────
      dwindle = {
          preserve_split = true,
          smart_split    = false,
      },

      -- ── Miscellaneous ──────────────────────────────────────────────────────────
      misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        animate_manual_resizes       = false,
        animate_mouse_windowdragging = false,
        focus_on_activate = false,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms  = true,
      },

      -- ── Cursor ─────────────────────────────────────────────────────────────────
      cursor = {
          inactive_timeout    = 3,
          no_hardware_cursors = false,
      },
    })

      hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
      hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
      hl.curve("linear",         { type = "bezier", points = { {0, 0}, {1, 1} } })
      hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } })
      hl.curve("quick",         { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

      hl.animation({ leaf = "windows",       enabled = true, speed = 5.39, bezier = "easeOutQuint",  style = "slide" })
      hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.10, bezier = "easeOutQuint",  style = "slide" })
      hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",        style = "slide" })

      hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
      hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
      hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
      hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })

      hl.animation({ leaf = "layers",       enabled = true, speed = 3.81, bezier = "easeOutQuint" })
      hl.animation({ leaf = "layersIn",     enabled = true, speed = 4.00, bezier = "easeOutQuint",  style = "fade" })
      hl.animation({ leaf = "layersOut",    enabled = true, speed = 1.50, bezier = "linear",         style = "fade" })

      hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
      hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })

      hl.animation({ leaf = "workspaces",     enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
      hl.animation({ leaf = "workspacesIn",   enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
      hl.animation({ leaf = "workspacesOut",  enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
  '';
}
