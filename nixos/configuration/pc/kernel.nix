{ pkgs, ...}:
{
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  #boot.kernelPackages = pkgs.linuxPackages;
}
