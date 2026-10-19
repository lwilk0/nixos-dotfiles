{...}: {
  # Hardware and display choices for the current host.  Keep reusable
  # Hyprland settings in modules/home-manager/hyprland instead.
  dotfiles.hyprland = {
    monitorsLua = ''
      hl.monitor({
        output = "HDMI-A-6",
        mode = "1920x1080@75",
        position = "0x0",
        scale = "1",
      })

      hl.monitor({
        output = "DP-1",
        mode = "1920x1080@60",
        position = "1920x0",
        scale = "1",
      })
    '';

    environmentLua = ''
      hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
      hl.env("XDG_SESSION_TYPE", "wayland")
      hl.env("XDG_SESSION_DESKTOP", "Hyprland")

      hl.env("WINEFSYNC", "1")
      hl.env("WINEESYNC", "1")
      hl.env("ROCR_VISIBLE_DEVICES", "1")
      hl.env("HSA_OVERRIDE_GFX_VERSION", "11.0.0")
      hl.env("LIBVA_DRIVER_NAME", "radeonsi")

      hl.env("GDK_BACKEND", "wayland,x11")
      hl.env("QT_QPA_PLATFORM", "wayland;xcb")
      hl.env("SDL_VIDEODRIVER", "wayland")
      hl.env("CLUTTER_BACKEND", "wayland")
      hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
      hl.env("XCURSOR_SIZE", "11")
    '';
  };
}
