{...}: {
  programs.caelestia.settings = {
    services = {
      useFahrenheit = false;
      useFahrenheitPerformance = false;
      useTwelveHourClock = false;
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
