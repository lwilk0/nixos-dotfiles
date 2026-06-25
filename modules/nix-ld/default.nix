{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Core libraries required by MT-PDK2
      libx11
      libxcb
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
    ];
  };
}
