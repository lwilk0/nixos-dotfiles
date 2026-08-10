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
          passes             = 3,
          ignore_opacity     = true,

          noise              = 0.08,
          contrast           = 1.5,

          new_optimizations  = true,
          xray               = false,
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

    hl.on("hyprland.start", function ()
      hl.exec_cmd("protonvpn-app")
    end)

    hl.curve("smoothOut",      { type = "bezier", points = { {0.36, 0.00}, {0.66, -0.56} } })
    hl.curve("smoothIn",       { type = "bezier", points = { {0.25, 1.00}, {0.50, 1.00}  } })
    hl.curve("overshoot",      { type = "bezier", points = { {0.05, 0.90}, {0.10, 1.05}  } })
    hl.curve("softSnap",       { type = "bezier", points = { {0.40, 0.00}, {0.20, 1.00}  } })
    hl.curve("fluent",         { type = "bezier", points = { {0.00, 0.00}, {0.20, 1.00}  } })
    hl.curve("easeInOutExpo",  { type = "bezier", points = { {0.87, 0.00}, {0.13, 1.00}  } })

    -- Windows
    hl.animation({ leaf = "windows",       enabled = true, speed = 5.00, bezier = "overshoot",  style = "popin 80%" })
    hl.animation({ leaf = "windowsIn",     enabled = true, speed = 5.00, bezier = "overshoot",  style = "popin 80%" })
    hl.animation({ leaf = "windowsOut",    enabled = true, speed = 4.00, bezier = "smoothOut",  style = "popin 95%" })
    hl.animation({ leaf = "windowsMove",   enabled = true, speed = 4.00, bezier = "softSnap"                        })
    -- Layers
    hl.animation({ leaf = "layersIn",      enabled = true, speed = 7.00, bezier = "smoothIn",   style = "slide"     })
    hl.animation({ leaf = "layersOut",     enabled = true, speed = 8.00, bezier = "softSnap",   style = "slide"     })
    -- Fade
    hl.animation({ leaf = "fade",          enabled = true, speed = 4.00, bezier = "smoothIn" })
    hl.animation({ leaf = "fadeIn",        enabled = true, speed = 4.00, bezier = "smoothIn" })
    hl.animation({ leaf = "fadeOut",       enabled = true, speed = 4.00, bezier = "smoothOut" })
    hl.animation({ leaf = "fadeSwitch",    enabled = true, speed = 4.00, bezier = "smoothIn" })
    hl.animation({ leaf = "fadeShadow",    enabled = true, speed = 4.00, bezier = "smoothIn" })
    hl.animation({ leaf = "fadeDim",       enabled = true, speed = 4.00, bezier = "smoothIn" })
    hl.animation({ leaf = "fadeDpms",      enabled = true, speed = 4.00, bezier = "smoothIn" })
    hl.animation({ leaf = "fadeLayers",    enabled = true, speed = 3.00, bezier = "softSnap" })
    -- Workspaces
    hl.animation({ leaf = "workspaces",          enabled = true, speed = 5.00, bezier = "overshoot", style = "slidefade 30%" })
    hl.animation({ leaf = "specialWorkspace",    enabled = true, speed = 1.21, bezier = "overshoot", style = "slidefadevert 30%" })
  '';
}
