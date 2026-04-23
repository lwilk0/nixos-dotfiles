{pkgs, ...}: {
  # Install theme into ~/.local/share/Kvantum/Aesthetic-Night
  xdg.dataFile."Kvantum/Aesthetic-Night".source =
    ../../themes/aesthetic-night/kvantum/Aesthetic-Night;

  # Enable Qt theming via Home Manager (this sets env vars + packages)
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum-dark"; # you can change this later in Kvantum Manager if you want
  };

  # Kvantum plugin packages for Qt5 + Qt6
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
  ];
}
