{...}: { 
  imports = [
    ../common
    ../bluetooth.nix
    ./user.nix
    ./hardware-configuration.nix
    ./kernel.nix
  ];
}
