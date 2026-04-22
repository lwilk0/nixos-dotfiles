{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = [
      # ── Wayland / desktop identification ────────────────────────────────────
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"

      # ── Wine / yabridge synchronisation ─────────────────────────────────────
      # WINEFSYNC uses Linux futex2 for cross-process synchronisation — much
      # lower overhead than the default wineserver approach.  The CachyOS
      # kernel ships with futex2 support so this is always safe to enable.
      # It benefits both yabridge VST plugins (Archetype Gojira, SSD5.5) and
      # any Wine/Proton games.
      "WINEFSYNC,1"

      # WINEESYNC is the older eventfd-based fallback.  Keep it on as a
      # safety net for plugins/games that don't yet support fsync.
      "WINEESYNC,1"

      # ── ROCm / AMD GPU compute ───────────────────────────────────────────────
      # Tell ROCm which GPU to use (card1 = RX 9060 XT discrete GPU;
      # card0 = Intel UHD 770 iGPU which we don't want for compute).
      # The HSA_OVERRIDE_GFX_VERSION is set to 11.0.0 which covers RDNA3/4
      # and lets ROCm-based tools (Blender, Stable Diffusion, etc.) recognise
      # the Navi 44 / RX 9060 XT until full RDNA4 support lands in ROCm.
      "ROCR_VISIBLE_DEVICES,1"
      "HSA_OVERRIDE_GFX_VERSION,11.0.0"

      # ── VA-API / hardware video decode ───────────────────────────────────────
      # Prefer the AMD RADV VAAPI driver for the discrete GPU.
      # The Intel iGPU (i915 / Quick Sync) is still available system-wide;
      # this just makes Brave, mpv, etc. default to the AMD card.
      "LIBVA_DRIVER_NAME,radeonsi"

      # ── Toolkit / theme passthrough ──────────────────────────────────────────
      # Force GTK/Qt apps to use the Wayland backend instead of XWayland.
      "GDK_BACKEND,wayland,x11"
      "QT_QPA_PLATFORM,wayland;xcb"
      "SDL_VIDEODRIVER,wayland"
      "CLUTTER_BACKEND,wayland"

      # ── Cursor ───────────────────────────────────────────────────────────────
      # Ensure XWayland apps (Wine, some games) pick up the correct cursor theme.
      "XCURSOR_THEME,Bibata-Modern-Classic"
      "XCURSOR_SIZE,11"
    ];
  };
}
