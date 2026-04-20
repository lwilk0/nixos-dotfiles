{ config, pkgs, ... }:

let
  hayase-image = pkgs.fetchurl {
    url = "https://api.hayase.watch/files/linux-hayase-6.4.58-linux.AppImage";
    sha256 = "0xbi7b2mpgqkh4yf2b28bpncigf1jkx8g5n8h0grrc6s9l6pmz6j";
  };

  hayase-icon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/hayase-app/.github/main/profile/logo_white.svg";
    sha256 = "45a2ced7eaae9651d35263ffbe4d4ca291b4c0be1f519f0ba8ce448b5396b38a";
  };

  hayase = pkgs.appimageTools.wrapType2 {
    pname = "hayase";
    version = "6.4.58";
    src = hayase-image;
  };
in {
  home.packages = [ hayase ];

  xdg.dataFile."icons/hayase.svg".source = hayase-icon;
  xdg.desktopEntries.hayase = {
    name = "Hayase";
    comment = "Hayase streaming client";
    exec = "hayase";
    icon = "hayase";
    terminal = false;
    type = "Application";
    categories = [ "Network" "Video" ];
  };
}
