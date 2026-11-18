{
  pkgs-unstable,
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;

  signalCli = pkgs-unstable.signal-cli;

  signalEnv = "${config.home.homeDirectory}/.config/hermes-agent/signal.env";

  signalDaemon = pkgs.writeShellScript "signal-cli-daemon" ''
    exec ${signalCli}/bin/signal-cli \
      --account "$SIGNAL_ACCOUNT" \
      daemon --http 127.0.0.1:8080
  '';

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
  programs.hermes-agent = {
    enable = true;
    desktop.enable = true;
  };

  services.hermes-agent = {
    enable = true;
    package = hermesPackage;

    gateway.enable = true;

    settings = {
      model = {
        provider = "llamacpp";
        default = "Qwen3.8-27B-UD-Q4_K_M";
      };

      local_runtime = {
        enabled = true;
        backend = "vulkan";
      };

      model_aliases = {
        qwen-local = {
          model = "Qwen3.8-27B-UD-Q4_K_M";
          provider = "llamacpp";
        };
      };
    };

    environmentFiles = [
      signalEnv
    ];
  };

  home.packages = [
    signalCli
  ];

  systemd.user.services.signal-cli = {
    Unit = {
      Description = "Signal CLI HTTP daemon for Hermes";
      After = ["network.target"];
    };

    Service = {
      EnvironmentFile = signalEnv;
      ExecStart = "${signalDaemon}";

      Restart = "on-failure";
      RestartSec = "5s";
      UMask = "0077";
    };

    Install.WantedBy = ["default.target"];
  };
}
