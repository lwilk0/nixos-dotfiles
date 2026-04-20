{ config, pkgs, ... }:
let
  cream-image = pkgs.fetchurl {
    url = "https://github.com/Novattz/creamlinux-installer/releases/download/v1.5.0/Creamlinux_1.5.0_amd64.AppImage";
    sha256 = "1x8869fdfvhyzxlz3k90bn4hi4d7sa0p1llxfd4sk57chhv332fn";
  };

  creamlinux = pkgs.appimageTools.wrapType2 {
    pname = "creamlinux";
    version = "1.5.0";
    src = cream-image;
  };
in {
  home.packages = [ creamlinux ];

  xdg.desktopEntries.creamlinux = {
    name = "Creamlinux";
    comment = "Creamlinux DLC injector";
    exec = "creamlinux";
    icon = "creamlinux";
    terminal = false;
    type = "Application";
    categories = [ "Game" ];
  };
}
