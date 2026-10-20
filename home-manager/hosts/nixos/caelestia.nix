
{ ... }: {
  programs.caelestia.settings = {
    services = {
      sensorUnits = "Celsius";
      weatherUnits = "Celsius";
      clockFormat = "TwentyFourHour";
    };

    appearance.rounding.scale = 1.0;

    background = {
      desktopClock = {
        enabled = true;
        position = "top-right";
      };

      visualiser.enabled = true;
    };

    bar = {
      activeWindow.compact = true;
      clock.showIcon = false;

      status.showBattery = false;
    };
  };
}

