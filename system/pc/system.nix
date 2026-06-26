{
  lib,
  pkgs,
  ...
}: {
  system.stateVersion = "26.05";

  # ── THE FIX: Revert to classic initrd ────────────────────────────────────
  # NixOS 26.05 forces systemd in the initrd, which hangs on dual-GPU/IOMMU
  # setups during early boot. This reverts to the stable 24.11 behavior.
  boot.initrd.systemd.enable = false;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    max-jobs = "auto";
    cores = 0;
    system-features = [
      "nixos-test"
      "benchmark"
      "big-parallel"
      "kvm"
      "gccarch-x86-64-v3"
    ];
  };

  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "20%";
  };

  boot.kernelPackages = pkgs.linuxPackages;

  boot.kernelParams = [
    "mitigations=auto"
    "swapaccount=1"
    "btusb.enable_autosuspend=0"
    "intel_iommu=on"
    "iommu=pt"
    "pcie_aspm=off"
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
    "amdgpu"
    "i915"
  ];

  boot.kernel.sysctl = {
    "vm.dirty_bytes" = 536870912;
    "vm.dirty_background_bytes" = 134217728;
    "vm.vfs_cache_pressure" = 50;
  };

  fileSystems."/".options = lib.mkForce [
    "noatime"
  ];

  swapDevices = [];
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--max-free 2G";
  };

  services.fstrim.enable = true;
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

  systemd.settings.Manager = {
    DefaultLimitNOFILE = "1048576";
  };

  environment.etc."systemd/user.conf.d/99-limits.conf".text = ''
    [Manager]
    DefaultLimitNOFILE=1048576
  '';

  systemd.services.nix-daemon.serviceConfig.LimitNOFILE = 1048576;
}
