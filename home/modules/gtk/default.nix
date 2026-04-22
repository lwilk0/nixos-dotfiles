{ lib, pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 11;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      package = pkgs.catppuccin-gtk;
      name = "catppuccin-frappe-blue-standard";
    };
  };

  # GTK apps and some Wayland compositors occasionally regenerate these files
  # as plain files, causing Home Manager to refuse to place its own symlinks
  # ("would be clobbered"). This activation script runs before the writeBoundary
  # step (where HM creates all managed symlinks) and deletes any plain-file
  # versions it finds. Symlinks that are already managed by HM are left alone.
  home.activation.removeGtkPlainFiles = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    for f in \
      "$HOME/.gtkrc-2.0" \
      "$HOME/.config/gtk-3.0/settings.ini" \
      "$HOME/.config/gtk-4.0/settings.ini" \
      "$HOME/.config/gtk-4.0/gtk.css" \
      "$HOME/.local/share/icons/default/index.theme"; do
      if [[ -e "$f" && ! -L "$f" ]]; then
        echo "home-manager: removing plain file $f (will be replaced with managed symlink)"
        rm -f "$f"
      fi
    done
  '';
}
