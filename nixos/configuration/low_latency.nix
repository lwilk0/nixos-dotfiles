{pkgs, ...}: {
  security.rtkit.enable = true;

  boot.kernelParams = [
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

  nix.daemonCPUSchedPolicy = "idle";
  nix.daemonIOSchedClass = "idle";
}
