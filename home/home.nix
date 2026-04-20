{ lib, config, pkgs, inputs, ... }:
let
  caelestia-shell = inputs.caelestia-shell.packages."x86_64-linux".default.override {
    withCli = true;
  };
  caelestia-cli = inputs.caelestia-cli.packages."x86_64-linux".default;
  yazi-themed = pkgs.writeShellScriptBin "yazi-themed" ''
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
    exec ${pkgs.yazi}/bin/yazi "$@"
  '';
in
{
  imports = [
    ./modules/hyprland
    ./modules/quickshell
    ./modules/kitty
    ./modules/zsh
    ./modules/fastfetch
    ./modules/gtk
    ./modules/git
    ./modules/portal
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "wilko";
  home.homeDirectory = "/home/wilko";
  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    yazi-themed
    brave
    mullvad-vpn
    qbittorrent
    bluetuith
    caelestia-shell
    caelestia-cli
    btop
    fastfetch
    discord
    obsidian
    ferdium
    nerd-fonts.jetbrains-mono
    zed-editor-fhs
    xdg-utils
    gnome-keyring

    gpgme

    wineWow64Packages.staging
    winetricks

    qjackctl
    carla
    alsa-utils

    yabridge
    yabridgectl

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

    rustup
  ];

  qt.enable = true;

  home.sessionVariables = {
    LV2_PATH = "$HOME/.nix-profile/lib/lv2";
  };

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
