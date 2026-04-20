{ config, ... }:
{
  # Real-time audio privileges
  security.rtkit.enable = true;

  # Optional: Low latency kernel parameters
  boot.kernelParams = [ "threadirqs" "preempt=full" ];
}
