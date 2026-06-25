{lib, ...}: {
  xdg.configFile."hypr/binds.lua".text = ''


    local mod = "SUPER"
    local modShift = "SUPER + SHIFT"
    local modControl = "SUPER + CTRL"

    local terminal = "kitty"
    local fileManager = "kitty -- yazi-themed"
    local browser = "librewolf-perf"
    local launcher = "caelestia shell drawers toggle launcher"
    local screenshot = "grimblast"

      -- ── Regular binds (fire on press) ──────────────────────────────────────────

      -- ── Launch ───────────────────────────────────────────────────────────────
      hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal),        { description = "Launch terminal" })
      hl.bind(mod .. " + space",  hl.dsp.exec_cmd(launcher),        { description = "launch app launcher" })
      hl.bind(mod .. " + W",      hl.dsp.exec_cmd(browser),         { description = "Launch browser" })
      hl.bind(mod .. " + E",      hl.dsp.exec_cmd(fileManager),     { description = "Launch file manager" })
      hl.bind(mod .. " + B",      hl.dsp.exec_cmd("blueman-manager"), { description = "Launch bluetooth manager" })

      -- ── Window management ─────────────────────────────────────────────────────
      hl.bind(mod .. " + Q", hl.dsp.exec_cmd("~/.dotfiles/scripts/hypr/kill.sh"),                  { description = "Kill active window" })
      hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Toggle Fullscreen" })
      hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }),                           { description = "Toggle Floating" })
      -- bind("modShift", "M", "exit")

      -- ── Focus movement ────────────────────────────────────────────────────────
      hl.bind(mod .. " + left",  hl.dsp.focus({ direction = "left" }),  { description = "Move focus left" })
      hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Move focus right" })
      hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "up" }),    { description = "Move focus up" })
      hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "down" }),  { description = "Move focus down" })
      hl.bind(mod .. " + H",     hl.dsp.focus({ direction = "left" }),  { description = "Move focus left" })
      hl.bind(mod .. " + L",     hl.dsp.focus({ direction = "right" }), { description = "Move focus right" })
      hl.bind(mod .. " + K",     hl.dsp.focus({ direction = "up" }),    { description = "Move focus up" })
      hl.bind(mod .. " + J",     hl.dsp.focus({ direction = "down" }),  { description = "Move focus down" })

      -- ── Window movement ───────────────────────────────────────────────────────
      for i = 1, 4 do
        local arrowkey = { "Left", "Right", "Up", "Down" }
        local focusdir = { "l", "r", "u", "d" }
        hl.bind("SUPER + SHIFT + " .. arrowkey[i], hl.dsp.window.move({ direction = focusdir[i] }),
          { description = "Window: Move " .. arrowkey[i] })
      end

      -- ── Keyboard resize ───────────────────────────────────────────────────────
      hl.bind(modControl .. " + right", hl.dsp.window.resize({ x = 100, y = 0,  relative = true }), { repeating = true }, { description = "Increase window width with keyboard" })
      hl.bind(modControl .. " + left",  hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true }, { description = "Reduce window width with keyboard" })
      hl.bind(modControl .. " + down",  hl.dsp.window.resize({ x = 0, y = 100,  relative = true }), { repeating = true }, { description = "Increase window height with keyboard" })
      hl.bind(modControl .. " + up",    hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true }, { description = "Reduce window height with keyboard" })
      hl.bind(modControl .. " + H",     hl.dsp.window.resize({ x = 100, y = 0,  relative = true }), { repeating = true }, { description = "Increase window width with keyboard" })
      hl.bind(modControl .. " + L",     hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true }, { description = "Reduce window width with keyboard" })
      hl.bind(modControl .. " + K",     hl.dsp.window.resize({ x = 0, y = 100,  relative = true }), { repeating = true }, { description = "Increase window height with keyboard" })
      hl.bind(modControl .. " + J",     hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true }, { description = "Reduce window height with keyboard" })

      -- ── Screenshots ───────────────────────────────────────────────────────────
      hl.bind(mod .. " + Print",      hl.dsp.exec_cmd("grimblast --freeze copy area"))
      hl.bind("Print",                hl.dsp.exec_cmd("grimblast copy output"))
      hl.bind(modShift .. " + Print", hl.dsp.exec_cmd("grimblast --freeze save area"))

      -- ── Media control (software MPRIS) ────────────────────────────────────────
      hl.bind(mod .. " + period", hl.dsp.exec_cmd("playerctl next"),       { locked = true })
      hl.bind(mod .. " + comma",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
      hl.bind(mod .. " + slash",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

      -- ── Volume control (software fallback) ────────────────────────────────────
      hl.bind(mod .. " + equal", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),    { locked = true })
      hl.bind(mod .. " + minus", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),    { locked = true })
      hl.bind(mod .. " + M",     hl.dsp.exec_cmd("wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

      -- ── Audio-output switcher ─────────────────────────────────────────────────
      hl.bind(mod .. " + A",      hl.dsp.exec_cmd("wpctl set-default $(wpctl status | awk '/AirPods Pro/{print $2}' | tr -d '.')"))
      hl.bind(modShift .. " + A", hl.dsp.exec_cmd("wpctl set-default $(wpctl status | awk '/Built-in Audio Analog/{print $2}' | tr -d '.' | head -1)"))

      hl.bind(mod ..      " + G", hl.dsp.exec_cmd("~/.dotfiles/scripts/guitar.sh"))
      hl.bind(modShift .. " + G", hl.dsp.exec_cmd("~/.dotfiles/scripts/unguitar.sh"))

      -- ── Workspace switch + move (1-9, 0 → 10) ────────────────────────────────
      for i = 1, 10 do
        local key = i % 10
        hl.bind(mod .. " + " .. key,                  hl.dsp.focus({ workspace = i}), { description = "Focus workspace " .. i })
        hl.bind(modShift .. " + " .. key,     hl.dsp.window.move({ workspace = i }), { description = "Move window to workspace " .. i })
      end

      hl.bind("XF86AudioPlay",    hl.dsp.exec_cmd("playerctl play-pause"), {locked = true })
      hl.bind("XF86AudioNext",    hl.dsp.exec_cmd("playerctl next"),       { locked = true })
      hl.bind("XF86AudioPrev",    hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
      hl.bind("XF86AudioStop",    hl.dsp.exec_cmd("playerctl stop"),       { locked = true })
      hl.bind("XF86AudioMute",    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),   { locked = true })
      hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

      -- ── Repeat binds (fire on hold) ───────────────────────────────────────────
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume      @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })

      -- ==========================================
      -- MINI KEYBOARD STATE MACHINE
      -- ==========================================
      hl.bind("XF86Launch8", hl.dsp.exec_cmd("~/.dotfiles/scripts/minikb.sh switch"))

      -- W A S D Buttons
      hl.bind("XF86Tools",   hl.dsp.exec_cmd("~/.dotfiles/scripts/minikb.sh w"))
      hl.bind("XF86Launch5", hl.dsp.exec_cmd("~/.dotfiles/scripts/minikb.sh a"))
      hl.bind("XF86Launch6", hl.dsp.exec_cmd("~/.dotfiles/scripts/minikb.sh s"))
      hl.bind("XF86Launch7", hl.dsp.exec_cmd("~/.dotfiles/scripts/minikb.sh d"))

      -- Knob Up / Down
      hl.bind("XF86Launch9", hl.dsp.exec_cmd("~/.dotfiles/scripts/minikb.sh up"))
      hl.bind("F19",         hl.dsp.exec_cmd("~/.dotfiles/scripts/minikb.sh down"))
  '';
}
