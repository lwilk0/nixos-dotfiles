{ config, ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    
    wireplumber.enable = true;

    wireplumber.extraConfig."92-low-latency" = {
      "monitor.alsa.rules" = [
        {
          matches = [ { "device.name" = "~alsa_card.*"; } ];
          actions = {
            update-props = {
              "node.latency" = "128/48000";
              "api.alsa.period-size" = 128;
              "api.alsa.headroom" = 128;
            };
          };
        }
      ];
    };

    # 2. KEEP THE PIPEWIRE GRAPH LIMITS STRICT
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 128;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 512; 
      };
    };
  };
}
