{
  lib,
  pkgs,
  ...
}: {
  system.stateVersion = "25.11";
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];

    # The i5-14600K has 20 threads (6 P-cores + 8 E-cores × 2).
    # max-jobs  = how many derivations to build in parallel
    # cores = 0 = give every build job all available threads
    max-jobs = "auto";
    cores = 0;

    # Advertise x86-64-v3 capability so Nix substitutes AVX2/BMI2/FMA-optimised
    # binaries from caches that offer them (e.g. Chaotic-nyx).
    # The i5-14600K satisfies every x86-64-v3 instruction requirement.
    system-features = [
      "nixos-test"
      "benchmark"
      "big-parallel"
      "kvm"
      "gccarch-x86-64-v3"
    ];
  };

  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  #boot.kernelPackages = pkgs.linuxPackages_6_18;
  boot.kernelParams = [
    "mitigations=auto" # keep some mitigations; change to off if you accept the risks
    "swapaccount=1"
    "btusb.enable_autosuspend=0"
    "bluetooth.disable_ertm=1"
    "intel_iommu=on" # For Intel CPUs
    "iommu=pt" # Passthrough mode
    "pcie_aspm=off" # Disable PCIe power saving
  ];

  # ── Per-device I/O scheduler ─────────────────────────────────────────────────
  # NVMe has its own deep internal queue; a host-side scheduler only adds latency.
  # Spinning disks benefit from BFQ's fair-queuing to reduce seek thrash.
  services.udev.extraRules = ''
    # NVMe: no scheduler — let the drive manage its own queue
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"

    # HDDs: BFQ for fair I/O and reduced seek latency
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"

    # NVMe: drop read-ahead to 128 KiB (drive pre-fetches internally)
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/read_ahead_kb}="128"

    # HDDs: keep a generous read-ahead for sequential streaming
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/read_ahead_kb}="2048"
  '';

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [
    linux-firmware
    intel-media-driver # iGPU (i915) VAAPI — Quick Sync video decode
    mesa
    libva
    libvpx
    vulkan-tools
    dxvk
  ];

  # ── GPU ──────────────────────────────────────────────────────────────────────
  # xserver is disabled; videoDrivers here would be a no-op, so it is omitted.
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # required for Steam, Wine, and 32-bit Vulkan/OpenGL

    # ROCm CLR exposes OpenCL on the RX 9060 XT (Navi 44 / RDNA4).
    # Unlocks GPU-accelerated compute in Blender, Stable Diffusion, etc.
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  boot.kernelModules = [
    "amdgpu"
    "i915" # keep for Intel Quick Sync hardware video decode
  ];

  # si_support / cik_support are only relevant for pre-GCN / GCN-1 cards (2012–2013).
  # The RX 9060 XT (Navi 44 / RDNA4) needs neither; removing them avoids misleading noise.

  # ── VM / memory tunables ─────────────────────────────────────────────────────
  # With 32 GB of RAM, percentage-based dirty limits translate to large absolute
  # windows.  Switch to byte-based knobs so the write-back window stays predictable
  # regardless of how much RAM is installed.
  #   dirty_bytes          ~512 MiB  — start background writeback at this point
  #   dirty_background_bytes~128 MiB — hard cap before processes are throttled
  boot.kernel.sysctl = {
    "vm.dirty_bytes" = 536870912; # 512 MiB
    "vm.dirty_background_bytes" = 134217728; # 128 MiB

    # With 32 GB RAM, keep more directory/inode metadata cached instead of
    # evicting it in favour of page-cache pressure.
    "vm.vfs_cache_pressure" = 50;
  };

  # ── Filesystem mount options ──────────────────────────────────────────────────
  # hardware-configuration.nix is read-only, so override the NVMe ext4 options here.
  #   noatime   — skip updating access timestamps on every read (saves ~1 write/read)
  #   commit=60 — flush the ext4 journal every 60 s instead of the default 5 s,
  #               reducing write amplification on the NVMe at the cost of a larger
  #               potential dirty window (acceptable since we have zram, not swap)
  fileSystems."/".options = lib.mkForce ["noatime" "commit=60"];

  # ── /tmp on tmpfs ─────────────────────────────────────────────────────────────
  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = ["mode=1777" "size=20%"];
  };

  # ── Swap / zram ───────────────────────────────────────────────────────────────
  # No physical swap; zram provides RAM-backed compressed swap.
  # zswap is NOT enabled — it would add a second compression stage on top of zram,
  # wasting CPU cycles with zero benefit.
  swapDevices = [];
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };

  # ── Nix housekeeping ─────────────────────────────────────────────────────────
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
      domain = "wilko"; # Apply to all users (or replace with your username)
      type = "soft"; # Soft limit
      item = "nofile";
      value = "1048576";
    }
    {
      domain = "wilko";
      type = "hard"; # Hard limit (-Hn)
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
