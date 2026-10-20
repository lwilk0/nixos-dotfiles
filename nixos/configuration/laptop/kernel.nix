{ pkgs, ...}:
{
  #boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  boot.kernelPackages = pkgs.linuxPackages;

  swapDevices = [
    {
      device = "/swapfile";
      size = 8192;
    }
  ];
}
