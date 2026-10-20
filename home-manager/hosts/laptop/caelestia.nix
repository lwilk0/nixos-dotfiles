{...}: {
  programs.caelestia.settings = {
    services = {
      sensorUnits = "Celsius";
      weatherUnits = "Celsius";
      clockFormat = "TwentyFourHour";
    };

    border.rounding = 15;

    background = {
      desktopClock = {
        enabled = true;
        position = "top-right";
      };
      # Saves continuous rendering and power while on battery.
      visualiser.enabled = false;
    };

    bar = {
      activeWindow.compact = true;
      clock.showIcon = false;
      status.showBattery = true;
    };
  };
}
