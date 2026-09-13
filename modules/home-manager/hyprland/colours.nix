{...}: {
  xdg.configFile."hypr/scheme/default.lua".text = ''
    background = "rgb(061115)"
    onBackground = "rgb(d9d7d6)"

    surface = "rgb(061115)"
    surfaceDim = "rgb(061115)"
    surfaceBright = "rgb(061115)"
    surfaceContainerLowest = "rgb(061115)"
    surfaceContainerLow = "rgb(061115)"
    surfaceContainer = "rgb(061115)"
    surfaceContainerHigh = "rgb(061115)"
    surfaceContainerHighest = "rgb(061115)"

    onSurface = "rgb(d9d7d6)"
    surfaceVariant = "rgb(d9d7d6)"
    onSurfaceVariant = "rgb(d9d7d6)"

    primary = "rgb(061115)"
    onPrimary = "rgb(d9d7d6)"
    primaryContainer = "rgb(061115)"
    onPrimaryContainer = "rgb(d9d7d6)"

    secondary = "rgb(061115)"
    onSecondary = "rgb(d9d7d6)"
    secondaryContainer = "rgb(061115)"
    onSecondaryContainer = "rgb(d9d7d6)"

    tertiary = "rgb(061115)"
    onTertiary = "rgb(d9d7d6)"
    tertiaryContainer = "rgb(061115)"
    onTertiaryContainer = "rgb(d9d7d6)"

    error = "rgb(061115)"
    onError = "rgb(d9d7d6)"
    errorContainer = "rgb(061115)"
    onErrorContainer = "rgb(d9d7d6)"

    rosewater = "rgb(d9d7d6)"
    flamingo = "rgb(d9d7d6)"
    pink = "rgb(061115)"
    mauve = "rgb(061115)"
    red = "rgb(061115)"
    maroon = "rgb(061115)"
    peach = "rgb(061115)"
    yellow = "rgb(061115)"
    green = "rgb(061115)"
    teal = "rgb(061115)"
    sky = "rgb(061115)"
    sapphire = "rgb(061115)"
    blue = "rgb(061115)"
    lavender = "rgb(061115)"

    text = "rgb(d9d7d6)"
    subtext0 = "rgb(d9d7d6)"
    subtext1 = "rgb(d9d7d6)"
    overlay0 = "rgb(d9d7d6)"
    overlay1 = "rgb(d9d7d6)"
    overlay2 = "rgb(d9d7d6)"
    surface0 = "rgb(061115)"
    surface1 = "rgb(061115)"
    surface2 = "rgb(061115)"
    base = "rgb(061115)"
    mantle = "rgb(061115)"
    crust = "rgb(061115)"

    term0 = "rgb(061115)"
    term1 = "rgb(061115)"
    term2 = "rgb(061115)"
    term3 = "rgb(061115)"
    term4 = "rgb(061115)"
    term5 = "rgb(061115)"
    term6 = "rgb(061115)"
    term7 = "rgb(d9d7d6)"

    term8 = "rgb(061115)"
    term9 = "rgb(061115)"
    term10 = "rgb(061115)"
    term11 = "rgb(061115)"
    term12 = "rgb(061115)"
    term13 = "rgb(061115)"
    term14 = "rgb(061115)"
    term15 = "rgb(d9d7d6)"

    inverseSurface = "rgb(d9d7d6)"
    inverseOnSurface = "rgb(061115)"
    outline = "rgb(061115)"
    outlineVariant = "rgb(061115)"
    shadow = "rgb(061115)"
    scrim = "rgb(061115)"
    surfaceTint = "rgb(061115)"

    success = "rgb(061115)"
    onSuccess = "rgb(d9d7d6)"
    successContainer = "rgb(061115)"
    onSuccessContainer = "rgb(d9d7d6)"
  '';

  # Caelestia files stay as normal Nix managed strings
  xdg.configFile."caelestia/cli.json".text = builtins.toJSON {
    theme = {
      enableTerm = true;
      enableHypr = true;
      enableGtk = true;
      enableQt = true;
      enableChromium = true;
      enableDiscord = true;
      enableSpicetify = true;
      enableFuzzel = true;
      enableBtop = true;
      enableNvtop = true;
      enableHtop = true;
      enableWarp = true;
      enableZed = true;
      enableCava = true;
    };
  };

  xdg.configFile."caelestia/templates/foot-aesthetic-night.ini".text = ''
    [colors]
    foreground={{ foreground.hex }}
    background={{ background.hex }}

    regular0={{ black.hex }}
    regular1={{ red.hex }}
    regular2={{ green.hex }}
    regular3={{ yellow.hex }}
    regular4={{ blue.hex }}
    regular5={{ magenta.hex }}
    regular6={{ cyan.hex }}
    regular7={{ white.hex }}

    bright0={{ bright-black.hex }}
    bright1={{ bright-red.hex }}
    bright2={{ bright-green.hex }}
    bright3={{ bright-yellow.hex }}
    bright4={{ bright-blue.hex }}
    bright5={{ bright-magenta.hex }}
    bright6={{ bright-cyan.hex }}
    bright7={{ bright-white.hex }}
  '';
}
