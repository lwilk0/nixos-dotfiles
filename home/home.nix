{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: let
  caelestia-cli = inputs.caelestia-cli.packages."x86_64-linux".default;

  yazi-themed = pkgs.writeShellScriptBin "yazi-themed" ''
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null
    exec ${pkgs.yazi}/bin/yazi "$@"
  '';
in {
  imports = [
    ./modules/hyprland
    ./modules/quickshell
    ./modules/kitty
    ./modules/zsh
    ./modules/fastfetch
    ./modules/gtk
    ./modules/git
    ./modules/portal
    ./modules/wireplumber
    ./modules/qt
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "wilko";
  home.homeDirectory = "/home/wilko";
  home.stateVersion = "25.11";

  home.packages = with pkgs;
    [
      # ── Core desktop ──────────────────────────────────────────────────────────
      yazi-themed
      brave
      mullvad-vpn
      qbittorrent
      caelestia-cli
      btop
      discord
      obsidian
      anki
      ferdium
      nerd-fonts.jetbrains-mono
      xdg-utils
      gnome-keyring
      fastfetch
      blueman

      # ── Utilities ────────────────────────────────────────────────────────────
      playerctl # MPRIS media control — used by Hyprland media keybinds
      wl-clipboard # wl-copy / wl-paste — essential for Wayland clipboard
      grimblast # Hyprland-aware screenshot wrapper around grim + slurp
      libnotify # notify-send — lets scripts send desktop notifications
      bat
      ripgrep
      fd
      lazygit

      # ── GPG ──────────────────────────────────────────────────────────────────
      gpgme

      # ── Wine / gaming ────────────────────────────────────────────────────────
      wineWow64Packages.staging # 64+32-bit Wine with staging patches
      winetricks

      # ── Neovim ───────────────────────────────────────────────────────────────
      neovim
      gcc
      tree-sitter

      # ── Pro audio ────────────────────────────────────────────────────────────
      qjackctl
      carla
      alsa-utils
      yabridge
      yabridgectl
      pipewire.jack

      # LV2 plugin bundle — merged into a single profile path so Carla / Bitwig
      # find everything under $HOME/.nix-profile/lib/lv2 without extra config.
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

      # ── Development ──────────────────────────────────────────────────────────
      rust-analyzer
      cargo
      rustfmt
      clippy
      bash-language-server
      nil
      yaml-language-server
      # Formatters & Linters
      shfmt
      alejandra
      prettierd
    ]
    ++ [
      pkgs-unstable.rustc
    ];

  # ── direnv — automatic nix dev-shell loading ──────────────────────────────
  # When you cd into ~/Projects/fmp (or any project with flake.nix / shell.nix
  # and an .envrc), the correct nix environment activates automatically.
  # nix-direnv caches the shell so it doesn't re-evaluate on every cd.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  # ── Qt theming ───────────────────────────────────────────────────────────
  qt.enable = true;

  # ── Session variables ────────────────────────────────────────────────────
  home.sessionVariables = {
    LV2_PATH = "$HOME/.nix-profile/lib/lv2";
    # Tell Rust / cargo to use sccache if it is ever added; harmless if not.
    # RUSTC_WRAPPER = "sccache";
  };

  # ── NeoVim ────────────────────────────────────────────────────────────────
  xdg.configFile."nvim" = {
    source = ./modules/nvim;
    recursive = true;
  };

  # ── Screenshots directory ─────────────────────────────────────────────────
  # grimblast's "save" mode writes here by default.
  home.file."Pictures/Screenshots/.keep".text = "";

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
