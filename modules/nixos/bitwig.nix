{ pkgs, ... }:
{
  programs.nix-ld.enable = true;
  environment.variables.NIX_PROFILES = "$HOME/.nix-profile";
  
  # Ensure the dummy libjack2 is completely gone from nix-ld
  programs.nix-ld.libraries = with pkgs; [
    alsa-lib
    libGL
    pipewire
    pipewire.jack
    vulkan-loader
    libX11
    libXcursor
    libXext
    libXi
    libXrender
    libXtst
    libxcb
    libxkbcommon
    stdenv.cc.cc.lib
    zlib
    gtk3
    glib
    pango
    cairo
    harfbuzz
    atk
    gdk-pixbuf
  ];

  # Create a custom launcher that shadows the broken Nix wrapper
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "bitwig-studio" ''
      # 1. Force the variables that the audio engine needs to find the PipeWire socket
      export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
      export DBUS_SESSION_BUS_ADDRESS="''${DBUS_SESSION_BUS_ADDRESS:-unix:path=$XDG_RUNTIME_DIR/bus}"

      # 2. Use LD_PRELOAD to FORCE the PipeWire libjack.so to be loaded.
      # This overrides any LD_LIBRARY_PATH manipulation Bitwig's scripts do.
      export LD_PRELOAD="${pkgs.pipewire.jack}/lib/libjack.so''${LD_PRELOAD:+:}$LD_PRELOAD"

      # 3. Execute the actual Bitwig internal script directly, skipping the broken Nix wrapper
      exec "/nix/store/mfn36yqbs2grp35rn08bsc2jkb4z2sgw-bitwig-studio-6.0/opt/bitwig-studio/bitwig-studio" "$@"
    '')
  ];
}