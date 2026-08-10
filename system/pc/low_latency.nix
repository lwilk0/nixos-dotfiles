{pkgs, ...}: {
  # ── Real-time / audio privileges ─────────────────────────────────────────────
  security.rtkit.enable = true;

  # power-profiles-daemon keeps the CPU governor reachable from userspace
  # (e.g. GNOME / KDE power settings) without fighting musnix's performance governor.
  services.power-profiles-daemon.enable = true;

  # ── Low-latency kernel parameters ────────────────────────────────────────────
  boot.kernelParams = [
    "threadirqs" # each IRQ gets its own kernel thread → better PREEMPT_RT behaviour
    "preempt=full" # full kernel preemption — lowest scheduling latency
    "intel_pstate=active" # Intel P-state in HWP mode; pairs with performance governor
  ];

  # ── Scheduler / RT tunables ───────────────────────────────────────────────────
  boot.kernel.sysctl = {
    # Allow RT threads to consume 100 % of a CPU (required for JACK / pro-audio)
    "kernel.sched_rt_runtime_us" = -1;

    # Disable proactive memory compaction — it causes latency spikes by moving
    # pages in the background.  On-demand compaction (via khugepaged) still runs.
    "vm.compaction_proactiveness" = 0;
  };

  # ── AMD GPU: full power-feature mask ─────────────────────────────────────────
  # Unlocks all power-management features on the RX 9060 XT (Navi 44 / RDNA4),
  # including manual clock/voltage control via CoreCtrl or similar tools.
  boot.extraModprobeConfig = ''
    options amdgpu ppfeaturemask=0xffffffff
  '';

  # ── AMD GPU: 3D_FULL_SCREEN power profile ────────────────────────────────────
  # The default BOOTUP_DEFAULT profile under-clocks the GPU.  Profile 1
  # (3D_FULL_SCREEN) removes the BoosterFreq cap and lets the driver use the
  # full performance state.  A udev rule alone is too early in boot; a
  # graphical-session target service fires at the right time.
  systemd.services.amdgpu-performance-profile = {
    description = "Set AMD GPU power profile to 3D_FULL_SCREEN";
    wantedBy = ["multi-user.target"];
    after = ["systemd-udev-settle.service"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  # ── Nix daemon deprioritisation ──────────────────────────────────────────────
  # Nix builds are CPU and I/O heavy.  Running the daemon at idle scheduling
  # priority means builds yield immediately to interactive workloads (audio,
  # games, desktop) without any manual intervention.
  nix.daemonCPUSchedPolicy = "idle";
  nix.daemonIOSchedClass = "idle";
}
