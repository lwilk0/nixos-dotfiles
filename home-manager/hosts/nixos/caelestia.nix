{...}: {
  programs.caelestia.settings = {
    services = {
      useFahrenheit = false;
      useFahrenheitPerformance = false;
      useTwelveHourClock = false;
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
