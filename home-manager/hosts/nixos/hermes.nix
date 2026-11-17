{
  pkgs-unstable,
  inputs,
  lib,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  stockPatchelf = pkgs.patchelf;

  hermesPmPackages =
    lib.filterAttrs (_: lib.isDerivation)
    (pkgs.callPackage "${inputs.hermes-agent}/nix/pm-packages.nix" {
      patchelf =
        stockPatchelf
        // {
          overrideAttrs = attrsPatch:
            if
              lib.versionAtLeast stockPatchelf.version "0.19"
              && lib.versionOlder stockPatchelf.version "0.19.3"
            then stockPatchelf.overrideAttrs attrsPatch
            else stockPatchelf;
        };
    });

  hermesPackage = inputs.hermes-agent.packages.${system}.default.override {
    pmPackages = hermesPmPackages;
  };
in {
  services.hermes-agent.package = hermesPackage;

  programs.hermes-agent = {
    enable = true;
    desktop.enable = true;
  };

  home.packages = [
    pkgs-unstable.signal-cli
  ];
}
