{
  inputs,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: let
  caelestia-cli = inputs.caelestia-cli.packages.${pkgs.stdenv.hostPlatform.system}.default;
  yazi-themed = pkgs.writeShellScriptBin "yazi-themed" ''
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
    exec ${pkgs.yazi}/bin/yazi "$@"
  '';
in {  
  home.packages = with pkgs; [
    yazi-themed
    caelestia-cli
    btop
    vscodium
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    xdg-utils
    gnome-keyring
    fastfetch
    blueman
    unzip
    jq
    imagemagick
    playerctl
    wl-clipboard
    grimblast
    libnotify
    bat
    ripgrep
    fd
    lazygit
    gpgme
    gcc
    tree-sitter
    rust-analyzer
    cargo
    rustfmt
    clippy
    bash-language-server
    nil
    yaml-language-server
    python3
    gdb
    jdk21
    shfmt
    alejandra
    prettierd
    pkgs-unstable.rustc
  ]; 
}
