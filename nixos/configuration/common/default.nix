{...}: {
  # Settings shared by every physical NixOS host.
  imports = [
    ../pipewire.nix
    ../bootloader.nix
    ../dm.nix
    ../zsh.nix
  ];
}
