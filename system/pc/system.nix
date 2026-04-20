{ config, pkgs, ... }:
{
  system.stateVersion = "25.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  boot.kernelParams = [
    "mitigations=auto"           # keep some mitigations; change to off if you accept risks
    "intel_pstate=enable"
    "elevator=bfq"               # BFQ scheduler
    "zswap.enabled=1"
    "zswap.max_pool_percent=20"
    "swapaccount=1"
    "idle=nomwait"
  ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  environment.systemPackages = with pkgs; [
    linux-firmware
    intel-media-driver
    mesa
    libva
    libvpx
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  boot.kernel.sysctl."vm.dirty_ratio" = 20;
  boot.kernel.sysctl."vm.dirty_background_ratio" = 5;

  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "mode=1777" "size=20%" ];
  };

  swapDevices = [ ];
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };

  hardware.graphics.enable = true;

  boot.kernelModules = [
    "amdgpu"
    "i915"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--max-free 2G";
  };

  boot.extraModprobeConfig = ''
    options amdgpu si_support=1 cik_support=1
  '';

  services.fstrim.enable = true;
  services.printing.enable = false;
  services.openssh.enable = false;
}
