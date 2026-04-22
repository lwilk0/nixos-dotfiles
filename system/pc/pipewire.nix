{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;

    wireplumber = {
      extraConfig."92-low-latency" = {
        "monitor.alsa.rules" = [
          {
            matches = [ { "device.name" = "~alsa_card.*"; } ];
            actions = {
              update-props = {
                "api.alsa.period-size"   = 128;
                "api.alsa.period-num"    = 2;
                "node.latency"           = "128/48000";
              };
            };
          }
        ];
      };

      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-disable-headset-profile.conf" ''
          wireplumber.profiles = {
            main = {
              monitor.alsa.properties = {
               # Disable the HSP/HFP (Telephony Duplex) profile
               device.profiles = "a2dp-sink"
             };
           };
         };
      '')
      ];
    };

    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate        = 48000;
        default.clock.quantum     = 128;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 256;
      };
    };
  };
}
