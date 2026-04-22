{ pkgs, ... }:
{
  # ── WirePlumber user configuration ───────────────────────────────────────────
  xdg.configFile."wireplumber/wireplumber.conf.d/50-default-devices.conf".text = ''
    wireplumber.settings = {
      # Default OUTPUT → AirPods Pro
      default-configured-node-name.Audio/Sink = "bluez_output.68_CA_C4_DD_C7_5A.1"

      # Default INPUT → NUX NGA-3BT
      default-configured-node-name.Audio/Source = "alsa_input.usb-NUX_NUX_NGA-3BT_202305241631-00.analog-stereo"
    }
  '';

  # ── CRITICAL: Enhanced Bluetooth Policy ──────────────────────────────────────
  # This is where most AirPods audio issues originate
  xdg.configFile."wireplumber/wireplumber.conf.d/51-bluetooth-policy.conf".text = ''
    wireplumber.settings = {
      # DO NOT auto-switch to headset profile when ANY app opens mic
      # This keeps AirPods on high-quality A2DP even when Discord/browser uses NUX
      bluetooth.autoswitch-to-headset-profile = false

      # Enable persistent storage for codec/profile preferences
      bluetooth.use-persistent-storage = true

      # NEW: Force specific codecs for AirPods Pro (if supported)
      bluetooth.codecs = ["aac", "sbc", "sbc-xq"]

      # NEW: Disable automatic profile switching entirely
      # This prevents the "first connection good, then bad" issue
      bluetooth.auto-switch = false
    }
  '';

  # ── NEW: Device-specific configuration for AirPods ──────────────────────────
  # This prevents profile degradation specifically for your AirPods
  xdg.configFile."wireplumber/wireplumber.conf.d/52-airpods-specific.conf".text = ''
    wireplumber.settings = {
      # Match your AirPods Pro specifically
      device.profile = {
        "bluez_output.68_CA_C4_DD_C7_5A.1" = {
          # Force A2DP profile only (no HFP with mic)
          available-profiles = ["a2dp-sink"]
          # Prefer AAC codec (better quality than SBC)
          preferred-codec = "aac"
        }
      }
    }
  '';

  # ── NEW: System-level PipeWire buffer optimization ──────────────────────────
  # Many AirPods crackling issues are caused by buffer underruns
  xdg.configFile."pipewire/pipewire.conf.d/10-airpods-buffer.conf".text = ''
    context.properties = {
      # Increase buffer size for Bluetooth stability
      default.clock.rate = 48000
      default.clock.quantum = 128
      default.clock.min-quantum = 512
      default.clock.max-quantum = 2048

      # Bluetooth-specific optimizations
      bluez5.enable-sbc-xq = true
      bluez5.enable-msbc = false
      bluez5.enable-hw-volume = true
      bluez5.headset-roles = [ "hsp_hs" "hfp_ag" ]
    }
  '';
}
