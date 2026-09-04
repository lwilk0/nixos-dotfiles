{pkgs, ...}: {
  # Copy GTK3 theme so it’s available to GTK apps
  home.packages = with pkgs; [
    (pkgs.runCommandLocal "aesthetic-night-gtk3-theme" {} ''
      mkdir -p $out/share/themes/Aesthetic-Night
      cp -r ${../../home-manager/themes/aesthetic-night/gtk3}/* $out/share/themes/Aesthetic-Night/
    '')
  ];

  xdg.configFile."gtk-4.0/gtk.css".source = ../../home-manager/themes/aesthetic-night/gtk4/gtk.css;
  xdg.configFile."gtk-4.0/assets".source = ../../home-manager/themes/aesthetic-night/gtk4/assets;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Aesthetic-Night";
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Aesthetic-Night";
      package = pkgs.adw-gtk3;
    };
  };

  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Aesthetic-Night
    gtk-application-prefer-dark-theme=1
    gtk-decoration-layout=close,maximize,minimize:menu
  '';
}
