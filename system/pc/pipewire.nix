{pkgs, ...}: {
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
    wireplumber.enable = true;

    # Remove the invalid "51-disable-headset-profile" configPackages injection.
    # Profile control is now handled cleanly via bluetooth.nix roles.

    # INCREASE quantum for Bluetooth stability.
    # 1024 is a safe value for Bluetooth A2DP.
    # You can lower it (e.g. 512) for USB devices, but keep it high for BT.
    extraConfig.pipewire."92-custom-buffer" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 1024;
        default.clock.min-quantum = 512;
        default.clock.max-quantum = 2048;
      };
    };
  };
}
