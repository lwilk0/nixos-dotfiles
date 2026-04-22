{ config, lib, pkgs, ... }:
let
  mod        = "SUPER";
  modShift   = "SUPER SHIFT";
  modControl = "SUPER CTRL";
  modAlt     = "SUPER ALT";

  terminal     = "kitty";
  fileManager  = "kitty -- yazi-themed";
  browser      = "brave";
  launcher     = "caelestia shell drawers toggle launcher";
  screenshot   = "grimblast";

  # Generate workspace switch + move binds for 1-9, with 0 → workspace 10.
  # This avoids repeating the same line 20 times.
  wsRange = builtins.genList (n: n + 1) 9;  # [ 1 2 3 4 5 6 7 8 9 ]

  # Key label: workspace 10 maps to the "0" key.
  wsKey = ws: toString (lib.mod ws 10);

  wsSwitchBinds = map (ws: "${mod}, ${wsKey ws}, workspace, ${toString ws}") wsRange
    ++ [ "${mod}, 0, workspace, 10" ];

  wsMoveBinds = map (ws: "${modShift}, ${wsKey ws}, movetoworkspace, ${toString ws}") wsRange
    ++ [ "${modShift}, 0, movetoworkspace, 10" ];
in
{
  wayland.windowManager.hyprland.settings = {

    # ── Regular binds (fire on press) ──────────────────────────────────────────
    bind =
      # ── Launch ───────────────────────────────────────────────────────────────
      [
        "${mod}, Return,  exec, ${terminal}"
        "${mod}, space,   exec, caelestia shell drawers toggle launcher"
        "${mod}, W,       exec, ${browser}"
        "${mod}, E,       exec, ${fileManager}"
        "${mod}, B,       exec, blueman-manager"

        # ── Window management ─────────────────────────────────────────────────
        "${mod},      Q, killactive"
        "${mod},      F, fullscreen"
        "${mod},      V, togglefloating"
        "${modShift}, M, exit"

        # ── Focus movement ────────────────────────────────────────────────────
        "${mod}, left,  movefocus, l"
        "${mod}, right, movefocus, r"
        "${mod}, up,    movefocus, u"
        "${mod}, down,  movefocus, d"
        "${mod}, H,     movefocus, l"
        "${mod}, L,     movefocus, r"
        "${mod}, K,     movefocus, u"
        "${mod}, J,     movefocus, d"

        # ── Window movement ───────────────────────────────────────────────────
        "${modShift}, left,  movewindow, l"
        "${modShift}, right, movewindow, r"
        "${modShift}, up,    movewindow, u"
        "${modShift}, down,  movewindow, d"
        "${modShift}, H,     movewindow, l"
        "${modShift}, L,     movewindow, r"
        "${modShift}, K,     movewindow, u"
        "${modShift}, J,     movewindow, d"

        # ── Keyboard resize ───────────────────────────────────────────────────
        "${modControl}, left,  resizeactive, -40 0"
        "${modControl}, right, resizeactive,  40 0"
        "${modControl}, up,    resizeactive,  0 -40"
        "${modControl}, down,  resizeactive,  0  40"
        "${modControl}, H,     resizeactive, -40 0"
        "${modControl}, L,     resizeactive,  40 0"
        "${modControl}, K,     resizeactive,  0 -40"
        "${modControl}, J,     resizeactive,  0  40"

        # ── Monitor focus / move ──────────────────────────────────────────────
        "${mod},      Tab,   focusmonitor, +1"
        "${modShift}, Tab,   movewindow,   mon:+1"

        # ── Screenshots ───────────────────────────────────────────────────────
        # SUPER+Print       → interactive region → clipboard
        # Print             → full screen        → clipboard
        # SUPER+SHIFT+Print → interactive region → save to ~/Pictures/Screenshots
        "${mod},      Print, exec, ${screenshot} --freeze copy area"
        ",            Print, exec, ${screenshot} copy output"
        "${modShift}, Print, exec, ${screenshot} --freeze save area"

        # ── Media control (software MPRIS) ────────────────────────────────────
        # These duplicates let the binds work even without XF86 keys on a TKL.
        "${mod}, period, exec, playerctl next"
        "${mod}, comma,  exec, playerctl previous"
        "${mod}, slash,  exec, playerctl play-pause"

        # ── Volume control (software fallback) ────────────────────────────────
        "${mod}, equal, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        "${mod}, minus, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        "${mod}, M,     exec, wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle"

        # ── Audio-output switcher ─────────────────────────────────────────────
        # Quickly swap the default PipeWire sink between AirPods and headphones.
        # SUPER+A → AirPods Pro (for videos / music)
        # SUPER+SHIFT+A → Built-in Analog (headphones on aux, for guitar monitoring)
        "${mod},      A, exec, wpctl set-default $(wpctl status | awk '/AirPods Pro/{print $2}' | tr -d '.')"
        "${modShift}, A, exec, wpctl set-default $(wpctl status | awk '/Built-in Audio Analog/{print $2}' | tr -d '.' | head -1)"
        
        "${mod},      G, exec, $HOME/.dotfiles/scripts/guitar.sh"
        "${modShift}, G, exec, $HOME/.dotfiles/scripts/unguitar.sh"
      ]
      ++ wsSwitchBinds
      ++ wsMoveBinds;

    # ── Locked binds (fire even when screen is locked) ─────────────────────────
    # XF86 media / volume keys should always work regardless of lock state.
    bindl = [
      ", XF86AudioPlay,  exec, playerctl play-pause"
      ", XF86AudioNext,  exec, playerctl next"
      ", XF86AudioPrev,  exec, playerctl previous"
      ", XF86AudioStop,  exec, playerctl stop"
      ", XF86AudioMute,  exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    # ── Repeat binds (fire on hold) ────────────────────────────────────────────
    # Volume held down should keep stepping.
    bindle = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume      @DEFAULT_AUDIO_SINK@ 5%-"
    ];

    # ── Mouse binds ────────────────────────────────────────────────────────────
    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];
  };
}
