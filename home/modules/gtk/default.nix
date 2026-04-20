{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 11;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark"; # Options: Papirus, Papirus-Light, Papirus-Dark
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      package = pkgs.catppuccin-gtk;
      name = "catppuccin-frappe-blue-standard";
    };
  };
}
