{...}: {
  # This host deliberately contains no desktop GPU, monitor, disk, or kernel
  # assumptions. Add its generated hardware configuration before exposing it
  # as a nixosConfiguration in flake.nix.
  imports = [
    ../common
    ../bluetooth.nix
    ./user.nix
    ./hardware-configuration.nix
  ];
}
