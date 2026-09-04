{pkgs, ...}: {
  security.rtkit.enable = true;

  services.power-profiles-daemon.enable = true;

  boot.kernelParams = [
    "threadirqs" # each IRQ gets its own kernel thread → better PREEMPT_RT behaviour
    "preempt=full" # full kernel preemption — lowest scheduling latency
    "intel_pstate=active" # Intel P-state in HWP mode; pairs with performance governor
  ];

  boot.kernel.sysctl = {
    "kernel.sched_rt_runtime_us" = -1;
    "vm.compaction_proactiveness" = 0;
  };

  boot.extraModprobeConfig = ''
    options amdgpu ppfeaturemask=0xffffffff
  '';

  systemd.services.amdgpu-performance-profile = {
    description = "Set AMD GPU power profile to 3D_FULL_SCREEN";
    wantedBy = ["multi-user.target"];
    after = ["systemd-udev-settle.service"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  nix.daemonCPUSchedPolicy = "idle";
  nix.daemonIOSchedClass = "idle";
}
