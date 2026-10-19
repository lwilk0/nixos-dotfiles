{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  inputs,
  localPkgsPath ? null,
  ...
}: let
  caelestia-cli = inputs.caelestia-cli.packages."x86_64-linux".default;
  yazi-themed = pkgs.writeShellScriptBin "yazi-themed" ''
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
    exec ${pkgs.yazi}/bin/yazi "$@"
  '';
in {
  imports =
    [
      ../modules/home-manager
      ./hosts/nixos/hyprland.nix
    ]
    ++ lib.optionals (localPkgsPath != null && builtins.pathExists localPkgsPath) [
      "${localPkgsPath}/appimages/default.nix"
      "${localPkgsPath}/deb/default.nix"
    ];

  nixpkgs.config.allowUnfree = true;

  home.username = "wilko";
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "26.05";

  home.packages = with pkgs;
    [
      yazi-themed
      qbittorrent
      caelestia-cli
      btop
      discord
      vscodium
      nerd-fonts.jetbrains-mono
      xdg-utils
      gnome-keyring
      fastfetch
      blueman
      samba
      nicotine-plus
      unzip
      libburn
      libisofs
      cdrtools
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-ugly
      gst_all_1.gst-plugins-base
      gst_all_1.gstreamer
      protonup-qt
      prismlauncher
      jq
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      appimage-run
      xwayland-satellite
      postman
      imagemagick
      libusb1
      freetube
      playerctl
      wl-clipboard
      grimblast
      libnotify
      bat
      ripgrep
      fd
      lazygit
      dxvk
      gpgme
      codex
      cdrdao
      dvdplusrwtools

      wineWow64Packages.yabridge
      winetricks

      gcc
      tree-sitter

      qjackctl
      carla
      alsa-utils
      yabridge
      yabridgectl
      pipewire.jack
      pulseaudio

      (pkgs.symlinkJoin {
        name = "all-lv2-plugins";
        paths = [
          gxplugins-lv2
          x42-plugins
          zam-plugins
          lsp-plugins
          mda_lv2
          calf
        ];
      })

      libx11
      libxcb-util
      libxcb-cursor
      libxkbcommon
      freetype
      glib
      cairo
      pango
      fontconfig
      libpng
      zlib

      rust-analyzer
      cargo
      rustfmt
      clippy
      bash-language-server
      nil
      yaml-language-server
      python3
      arduino-ide
      gdb
      dbvisualizer
      jdk21
      shfmt
      alejandra
      prettierd
    ]
    ++ [
      pkgs-unstable.rustc
    ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  qt.enable = true;

  home.sessionVariables = {
    LV2_PATH = "$HOME/.lv2/lib/lv2";
  };

  home.file."Pictures/Screenshots/.keep".text = "";

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  programs.hermes-agent.enable = true;

  /*
  services.dotfilesAutosync = {
    enable = true;
    branch = "auto-sync";
    remote = "origin";
    interval = "2h";
    startBootSec = "5min";
    authorName  = "dotfiles-autosync";
    authorEmail = "autosync@wilko.local";
  };
  */
}
