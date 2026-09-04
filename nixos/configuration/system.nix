{
  lib,
  pkgs,
  ...
}: {
  system.stateVersion = "25.11";

  # NixOS 26.05 forces systemd in the initrd, which hangs on dual-GPU/IOMMU
  # setups during early boot. This reverts to the stable 24.11 behavior.
  boot.initrd.systemd.enable = false;

  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "20%";
  };

  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  #boot.kernelPackages = pkgs.linuxPackages;

  boot.kernelParams = [
    "mitigations=off"
    "swapaccount=1"
    "btusb.enable_autosuspend=0"
    "intel_iommu=on"
    "iommu=pt"
  ];

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/read_ahead_kb}="128"
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/read_ahead_kb}="2048"
  '';

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [
    linux-firmware
    intel-media-driver
    mesa
    libva
    libvpx
    vulkan-tools
    dxvk
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  boot.kernelModules = [
    "usbmon"
    "amdgpu"
    "i915"
  ];

  boot.kernel.sysctl = {
    "vm.vfs_cache_pressure" = 50;
    "vm.swappiness" = lib.mkForce 180; # 180 is the recommended value for ZRAM by systemd devs
    "vm.watermark_boost_factor" = 125;
    "vm.watermark_scale_factor" = 125;
  };

  swapDevices = [];
  zramSwap = {
    enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--max-free 2G";
  };

  fileSystems."/".options = lib.mkForce [
    "noatime"
    "discard"
  ];

  services.printing.enable = false;
  services.openssh.enable = false;

  programs.dconf.enable = true;

  security.pam.loginLimits = [
    {
      domain = "wilko";
      type = "soft";
      item = "nofile";
      value = "1048576";
    }
    {
      domain = "wilko";
      type = "hard";
      item = "nofile";
      value = "1048576";
    }
  ];

  programs.gamemode = {
    enable = true;
    enableRenice = true; # Prioritizes the game process
    settings = {
      general = {
        renice = 10;
      };
      cpu = {
        park_cores = "no"; 
      };
    };
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    max-jobs = "auto";
    cores = 0;
    auto-optimise-store = true; # Hardlinks identical files, saves space and speeds up I/O
    http-connections = 50; 
    download-buffer-size = 524288000; # 500MB buffer
    system-features = [
      "nixos-test"
      "benchmark"
      "big-parallel"
      "kvm"
      "gccarch-x86-64-v3"
    ];
  };

  systemd.settings.Manager = {
    DefaultLimitNOFILE = "1048576";
  };

  environment.etc."systemd/user.conf.d/99-limits.conf".text = ''
    [Manager]
    DefaultLimitNOFILE=1048576
  '';

  systemd.services.nix-daemon.serviceConfig.LimitNOFILE = 1048576;
}
