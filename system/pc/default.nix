{ config, inputs, ... }:
{
  imports = [
    ./bluetooth.nix
    ./user.nix
    ./pipewire.nix
    ./bootloader.nix
    ./dm.nix
    ./zsh.nix
    ./system.nix
    ./network.nix
    ./hardware-configuration.nix
    ./low_latency.nix
  ];
}
