{pkgs, ...}: {
  # ── WirePlumber user configuration ───────────────────────────────────────────
  xdg.configFile."wireplumber/wireplumber.conf.d/50-default-devices.conf".text = ''
    wireplumber.settings = {
      # Default OUTPUT → AirPods Pro
      default-configured-node-name.Audio/Sink = "bluez_output.68_CA_C4_DD_C7_5A.1"

      # Default INPUT → NUX NGA-3BT
      default-configured-node-name.Audio/Source = "alsa_input.usb-NUX_NUX_NGA-3BT_202305241631-00.analog-stereo"
    }
  '';

  xdg.configFile."wireplumber/wireplumber.conf.d/50-alsa-config.conf".text = ''
  monitor.alsa.rules = [
       # ---------- Generic rule (AirPods, other outputs) ----------
    {
      matches = [
        {
          node.name = "~bluez_card.*"
        }
      ]
      actions = {
        update-props = {
          api.alsa.period-size = 1024
          api.alsa.use-acp = true
        }
      }
    }
  ]
'';
  

  xdg.configFile."wireplumber/wireplumber.conf.d/50-alsa-suspend.conf".text = ''
    monitor.alsa.rules = [
      {
        matches = [
          # This matches the value of the 'node.name' property of the node.
          {
            node.name = "~bluez_card.*"
          }
        ]
        actions = {
          update-props = {
            session.suspend-timeout-seconds = 0
          }
        }
      }
    ]
  '';
}
