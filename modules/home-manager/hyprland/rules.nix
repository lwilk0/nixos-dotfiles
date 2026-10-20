{...}: {
  xdg.configFile."hypr/rules.lua".text = ''
    hl.window_rule({
        match = { title = ".*Picture-in.*" },
        size = {640, 360},
    })

    hl.window_rule({
      name = "code",
      match = { class = "codium|code" },
      workspace = "4",
    })

    hl.window_rule({
      name = "audio",
      match = { class = "bitwig-studio|com.bitwig.BitwigStudio|Carla|qjackctl|org.helvum.Helvum|org.rncbc.qpwgraph|Ardour|REAPER|jalv.*" },
      workspace = "3",
    })

    hl.window_rule({
      name = "steam-games",
      match = { class = "(steam_app_).*" },
      immediate = true,
      workspace = "4",
    })
    hl.window_rule({
      name = "gamescope",
      match = { class = "gamescope" },
      immediate = true,
      workspace = "4",
    })

    
    hl.window_rule({
      name = "kitty-default",
      match = { class = "kitty" },
      float = false,
      opacity = "0.86 override 0.8 override 0.8 override",
    })

    hl.window_rule({
      match   = { class = "codium" },
      opacity = "0.86 override 0.8 override 0.8 override",
    })

    hl.window_rule({
      name = "keybind-help",
      match = { class = "keybind-help" },
      float = true,
      center = true,
      size = {900, 680},
    })

    hl.window_rule({
      match = { class = "bitwig-studio|com.bitwig.BitwigStudio" },
      suppress_event = "maximize",
    })

    hl.window_rule({
      match = { class = "yabridge-host.exe" },
      float = true,
      pin = true,
      no_focus = true,
    })

    hl.window_rule({
      match = { title = "Soldano SLO-100 X (GUI)" },
      float = true,
      pin = true,
      no_focus = true,
    })
  '';
}
