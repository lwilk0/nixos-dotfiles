{...}: {
  xdg.configFile."hypr/env.lua".text = ''
    -- ── Wayland / desktop identification ────────────────────────────────────
    hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
    hl.env("XDG_SESSION_TYPE",    "wayland")
    hl.env("XDG_SESSION_DESKTOP", "Hyprland")

    -- ── Wine / yabridge synchronisation ─────────────────────────────────────
    hl.env("WINEFSYNC", "1")
    hl.env("WINEESYNC", "1")

    -- ── ROCm / AMD GPU compute ───────────────────────────────────────────────
    hl.env("ROCR_VISIBLE_DEVICES",  "1")
    hl.env("HSA_OVERRIDE_GFX_VERSION", "11.0.0")

    -- ── VA-API / hardware video decode ───────────────────────────────────────
    hl.env("LIBVA_DRIVER_NAME", "radeonsi")

    -- ── Toolkit / theme passthrough ──────────────────────────────────────────
    hl.env("GDK_BACKEND",       "wayland,x11")
    hl.env("QT_QPA_PLATFORM",   "wayland;xcb")
    hl.env("SDL_VIDEODRIVER",   "wayland")
    hl.env("CLUTTER_BACKEND",   "wayland")

    -- ── Cursor ───────────────────────────────────────────────────────────────
    hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
    hl.env("XCURSOR_SIZE",  "11")
  '';
}
