{...}: {
  musnix.enable = true;

  users.users.wilko = {
    isNormalUser = true;
    autoSubUidGidRange = true; 
    extraGroups = ["wheel" "wireshark" "adbusers" "snd-virmidi" "audio" "realtime" "network" "networkmanager" "libvirtd" "cdrom" "dialout"]; # Enable ‘sudo’ for the user.
  };

  security.pam.loginLimits = [
    {
      domain = "@audio";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }
    {
      domain = "@audio";
      type = "-";
      item = "rtprio";
      value = "95";
    }
  ];

  networking.hostName = "nixos";
  time.timeZone = "Europe/London";

  boot.extraModprobeConfig = ''
    options snd-virmidi midi_devs=1
  '';

  systemd.services.NetworkManager-wait-online.enable = false;

  systemd.tmpfiles.rules = ["L+ /usr/bin/true - - - - /run/current-system/sw/bin/true"];
}
