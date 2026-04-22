{ config, ... }:
{
  programs.caelestia = {
    enable = true;

    settings = {
      services = {
        useFahrenheit = false;
        useFahrenheitPerformance = false;
        useTwelveHourClock = false;
      };

      border = {
        rounding = 15;
      };

      background = {
        desktopClock = {
          enabled = true;
          position = "top-right";
        };

        visualiser = {
          enabled = true;
        };
      };

      bar = {
        activeWindow = {
          compact = true;
        };

        clock = {
          showIcon = false;
        };

        status = {
          showBattery = false;
        };
      };
    };

    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
  };
}
