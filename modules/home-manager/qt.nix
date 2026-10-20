{ ... }: {
  xdg.configFile."Kvantum/Aesthetic-Night".source =
    ../../home-manager/themes/aesthetic-night/kvantum/Aesthetic-Night;

  qt = {
    enable = true;

    # Kvantum is the Qt widget style.
    style.name = "kvantum";

    kvantum = {
      enable = true;
      settings.General.theme = "Aesthetic-Night";
    };
  };
}
