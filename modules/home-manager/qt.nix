{pkgs, ...}: {
  xdg.dataFile."Kvantum/Aesthetic-Night".source =
    ../../home-manager/themes/aesthetic-night/kvantum/Aesthetic-Night;

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum-dark";
  };

  # Kvantum plugin packages for Qt5 + Qt6
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
  ];
}
