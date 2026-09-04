{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = false;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.users.wilko = {
    isNormalUser = true;
    autoSubUidGidRange = true; 
  };
}