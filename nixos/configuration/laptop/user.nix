{...}: {
  users.users.wilko = {
    isNormalUser = true;
    autoSubUidGidRange = true;
    extraGroups = ["wheel" "wireshark" "adbusers" "audio" "realtime" "network" "networkmanager" "libvirtd" "cdrom" "dialout" "input"];
  };

  networking.hostName = "laptop";
  time.timeZone = "Europe/London";

  networking.networkmanager.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.tmpfiles.rules = ["L+ /usr/bin/true - - - - /run/current-system/sw/bin/true"];
}
