{ config, ... }:
{
  musnix.enable = true;

  users.users.wilko = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "realtime" ]; # Enable ‘sudo’ for the user.
  };

  security.pam.loginLimits = [
    { domain = "@audio"; type = "-"; item = "memlock"; value = "unlimited"; }
    { domain = "@audio"; type = "-"; item = "rtprio"; value = "95"; }
  ];

  networking.hostName = "nixos";
  time.timeZone = "Europe/London";

  systemd.services.NetworkManager-wait-online.enable = false;

  nixpkgs.config.allowUnfree = true;
}
