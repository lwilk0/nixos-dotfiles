{...}: {
  xdg.configFile."hypr/scheme/default.conf".text = ''
    # Aesthetic Night remapped to Caelestia tokens
    $background = 061115
    $onBackground = d9d7d6

    $surface = 061115
    $surfaceDim = 061115
    $surfaceBright = 131e22
    $surfaceContainerLowest = 000a0e
    $surfaceContainerLow = 0d181c
    $surfaceContainer = 131e22
    $surfaceContainerHigh = 1c252c
    $surfaceContainerHighest = 484e5b

    $onSurface = d9d7d6
    $surfaceVariant = 484e5b
    $onSurfaceVariant = d9d7d6

    $primary = 6791c9
    $onPrimary = d9d7d6
    $primaryContainer = 6791c9
    $onPrimaryContainer = 061115

    $secondary = 67afc1
    $onSecondary = d9d7d6
    $secondaryContainer = 67afc1
    $onSecondaryContainer = 061115

    $tertiary = bc83e3
    $onTertiary = d9d7d6
    $tertiaryContainer = bc83e3
    $onTertiaryContainer = 061115

    $error = df5b61
    $onError = d9d7d6
    $errorContainer = df5b61
    $onErrorContainer = 061115

    # Catppuccin-style aliases used in various places
    $rosewater = e5e5e5
    $flamingo = d9d7d6
    $pink = c488ec
    $mauve = bc83e3
    $red = df5b61
    $maroon = 8cd7aa
    $peach = de8f78
    $yellow = e9967e
    $green = 78b892
    $teal = 67afc1
    $sky = 79aaeb
    $sapphire = 6791c9
    $blue = 6791c9
    $lavender = 79aaeb

    # Text shorthand
    $text = d9d7d6
    $subtext0 = 484e5b
    $subtext1 = d9d7d6
    $overlay0 = 595860
    $overlay1 = 6b6972
    $overlay2 = 7e7c86
    $surface0 = 25252a
    $surface1 = 37373d
    $surface2 = 48474e
    $base = 061115
    $mantle = 061115
    $crust = 000a0e

    # Terminal palette (matches Caelestia’s $term0..$term15 usage)
    $term0  = 1c252c
    $term1  = df5b61
    $term2  = 78b892
    $term3  = de8f78
    $term4  = 6791c9
    $term5  = bc83e3
    $term6  = 67afc1
    $term7  = d9d7d6

    $term8  = 484e5b
    $term9  = f16269
    $term10 = 8cd7aa
    $term11 = e9967e
    $term12 = 79aaeb
    $term13 = c488ec
    $term14 = 7acfe4
    $term15 = e5e5e5

    # Extras (from upstream defaults; keep if you don’t override them elsewhere)
    $inverseSurface = e5e1e7
    $inverseOnSurface = 313034
    $outline = 918f9a
    $outlineVariant = 47464f
    $shadow = 000000
    $scrim = 000000
    $surfaceTint = 6791c9

    $success = B5CCBA
    $onSuccess = 213528
    $successContainer = 374B3E
    $onSuccessContainer = D1E9D6
  '';

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
    # add other sections (toggles, etc.) if you use them, or omit them entirely
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
