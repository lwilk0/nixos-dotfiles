{ config, pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ./bitwig.nix {})
  ];
}
