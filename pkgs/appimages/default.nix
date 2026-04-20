{ pkgs, libs, ... }:
{
  imports = [
    ./hayase.nix
    ./creamlinux.nix
  ];

  home.packages = with pkgs; [
    (callPackage ./hydra.nix { })
  ];
}
