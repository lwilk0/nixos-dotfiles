{ pkgs, ... }:
{
    programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    alsa-lib
    libGL
    libjack2
    pipewire
    vulkan-loader
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    libxkbcommon
    stdenv.cc.cc.lib
    zlib

    gtk3
    glib
    pango
    cairo
    harfbuzz
    atk
    gdk-pixbuf
  ];
}
