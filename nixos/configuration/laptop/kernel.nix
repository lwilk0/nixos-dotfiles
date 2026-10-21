{pkgs, ...}: {
  #boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  boot.kernelPackages = pkgs.linuxPackages;

  hardware.enableRedistributableFirmware = true;
  boot.kernelParams = ["pcie_aspm=off"];

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
      size = 8192;
    }
  ];
}
