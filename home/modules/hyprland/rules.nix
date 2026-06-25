{...}: {
  xdg.configFile."hypr/rules.lua".text = ''
    -- ── Picture-in-Picture ────────────────────────────────────────────────
    hl.window_rule({
        match = { title = ".*Picture-in.*" },
        size = {640, 360},
    })

    -- ══════════════════════════════════════════════════════════════════════
    -- GAMING — TEARING & PERFORMANCE
    -- ══════════════════════════════════════════════════════════════════════
    hl.window_rule({
      match = { class = "(steam_app_).*" },
      immediate = true,
    })
    hl.window_rule({
      match = { class = "gamescope" },
      immediate = true,
    })
    hl.window_rule({
      match = { fullscreen = true },
      immediate = true,
    })
    --hl.window_rule({
    --  workspace = 4
    --  class = "(steam_app_).*",
    --})

    -- ══════════════════════════════════════════════════════════════════════
    -- KITTY — TERMINAL TRANSPARENCY
    -- ══════════════════════════════════════════════════════════════════════
    hl.window_rule({
      match   = { class = "kitty" },
      opacity = "0.9 override 0.9 override 0.9 override",
    })
    -- ══════════════════════════════════════════════════════════════════════
    -- AUDIO APPS — NO IDLE INHIBIT
    -- ══════════════════════════════════════════════════════════════════════
    hl.window_rule({
      match = { class = "bitwig-studio|com.bitwig.BitwigStudio" },
      suppress_event = "maximize",
    })

    -- ══════════════════════════════════════════════════════════════════════
    -- MISCELLANEOUS
    -- ══════════════════════════════════════════════════════════════════════
    hl.window_rule({
      match = { class = "yabridge-host.exe.so" },
      float = true,
      pin = true,
      no_focus = true,
    })
  '';
}
