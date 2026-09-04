{...}: {
  xdg.configFile."hypr/monitors.lua".text = ''
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
}
