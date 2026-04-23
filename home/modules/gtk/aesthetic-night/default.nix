{pkgs, ...}: {
  # Copy GTK3 theme so it’s available to GTK apps
  home.packages = with pkgs; [
    (pkgs.runCommandLocal "aesthetic-night-gtk3-theme" {} ''
      mkdir -p $out/share/themes/Aesthetic-Night
      cp -r ${../../../themes/aesthetic-night/gtk3}/* $out/share/themes/Aesthetic-Night/
    '')
  ];

  # GTK4 goes to ~/.config/gtk-4.0 (where many GTK4 apps still look)
  xdg.configFile."gtk-4.0/gtk.css".source = ../../../themes/aesthetic-night/gtk4/gtk.css;
  xdg.configFile."gtk-4.0/assets".source = ../../../themes/aesthetic-night/gtk4/assets;

  # Tell GTK to actually use it
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Aesthetic-Night";
      color-scheme = "prefer-dark";
    };
  };

  # Optional but recommended: ensure icons are dark-friendly
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Aesthetic-Night";
      package = pkgs.adw-gtk3; # fallback base theme; the runCommand above actually provides Aesthetic-Night
    };
  };

  # Also create a GTK3 settings.ini with the button layout rxyhn used:
  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Aesthetic-Night
    gtk-application-prefer-dark-theme=1
    gtk-decoration-layout=close,maximize,minimize:menu
  '';
}
