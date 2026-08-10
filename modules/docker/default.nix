{ pkgs, ... }: {
  virtualisation.docker.enable = true;

  imports = [
    ./containers.nix
  ];
}