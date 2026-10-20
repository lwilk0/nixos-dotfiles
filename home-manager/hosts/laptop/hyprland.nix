{...}: {
  # Keep this profile hardware-neutral. Hyprland will choose the laptop panel's
  # preferred mode and arrange any hot-plugged external displays automatically.
  dotfiles.hyprland = {
    monitorsLua = ''
      -- No fixed connector names, modes, scales, or positions on the laptop.
    '';

    environmentLua = ''
      hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
      hl.env("XDG_SESSION_TYPE", "wayland")
      hl.env("XDG_SESSION_DESKTOP", "Hyprland")

      hl.env("WINEFSYNC", "1")
      hl.env("WINEESYNC", "1")

      -- Prefer native Wayland rendering without assuming an Intel, AMD, or
      -- NVIDIA driver. This avoids inheriting the desktop's ROCm and VA-API
      -- overrides on different laptop hardware.
      hl.env("NIXOS_OZONE_WL", "1")
      hl.env("MOZ_ENABLE_WAYLAND", "1")
      hl.env("GDK_BACKEND", "wayland,x11")
      hl.env("QT_QPA_PLATFORM", "wayland;xcb")
      hl.env("SDL_VIDEODRIVER", "wayland")
      hl.env("CLUTTER_BACKEND", "wayland")
      hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
      hl.env("XCURSOR_SIZE", "11")
    '';
  };
}
