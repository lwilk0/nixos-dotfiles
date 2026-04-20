{ pkgs, config, inputs, ... }:
{
  imports = [
    ./caelestia.nix
  ];

  programs.quickshell = {
    enable = true;
    package = (inputs.caelestia-shell.packages.${pkgs.system}.default.override { withCli = true; });
    systemd.enable = true;
  };
}
