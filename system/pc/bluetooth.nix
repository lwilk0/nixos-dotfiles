{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez5-experimental;

    settings = {
      General = {
        Experimental = true;
        ControllerMode = "bredr";
        FastConnectable = "true";
        Enable = "Source,Sink,Media,Socket";
      };

      Policy = {
        autoEnable = true;
      };

      LE = {
        EnableAdvModInterleaveScan = true;
      };
    };
  };

  services.pipewire.wireplumber = {
    extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = ["a2dp_sink" "a2dp_source" "bap_sink" "bap_source" "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
        "bluez5.codecs" = ["sbc" "sbc_xq" "aac"];
        "bluez5.hfphsp-backend" = "native";
      };
    };
  };

  security.rtkit.enable = true;
}
