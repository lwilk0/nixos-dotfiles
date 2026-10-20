{...}: {
  imports = [
    ../common
    ../bluetooth.nix
    ../user.nix
    ../system.nix
    ../network.nix
    ../hardware-configuration.nix
    ../low_latency.nix
  ];
}
