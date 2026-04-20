{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "bitwig-studio";
  version = "6.0";

  # 1. The original .deb
  src = builtins.path {
    path = /. + "/home/wilko/Documents/Bitwig Studio 6 v6.0/Bitwig Studio 6 v6.0 LiNUX-Team Totoro/bitwig-studio-6.0.deb";
    name = "bitwig-studio-6.0.deb";
  };

  # 2. The cracked .jar
  crackedJar = builtins.path {
    path = /. + "/home/wilko/Documents/Bitwig Studio 6 v6.0/Bitwig Studio 6 v6.0 LiNUX-Team Totoro/Crack/bitwig.jar";
    name = "cracked-bitwig.jar";
  };

  nativeBuildInputs = with pkgs; [
    dpkg
    wrapGAppsHook3
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out
    cp -r . $out

    # ==========================================
    # 3. OVERWRITE THE ORIGINAL JAR WITH CRACK
    # ==========================================
    cp ${crackedJar} $out/opt/bitwig-studio/bin/bitwig.jar

    # 4. Create wrapper script
    mkdir -p $out/bin
    cat > $out/bin/bitwig-studio << EOF
    #!/bin/sh
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
      pkgs.xorg.xcbutilwm   
      pkgs.xorg.xcbutil     
      pkgs.xorg.libxcb
      pkgs.libGL
      pkgs.vulkan-loader
      pkgs.alsa-lib
      pkgs.pipewire
      pkgs.libjack2
    ]}:\$LD_LIBRARY_PATH"
    exec $out/opt/bitwig-studio/bitwig-studio "\$@"
    EOF
    chmod +x $out/bin/bitwig-studio

    # 5. Fix desktop shortcut
    mkdir -p $out/share/applications
    if [ -d $out/usr/share/applications ]; then
      for desktop in $out/usr/share/applications/*.desktop; do
        substituteInPlace "$desktop" \
          --replace "/opt/bitwig-studio" "$out/opt/bitwig-studio" \
          --replace "Exec=bitwig-studio" "Exec=$out/bin/bitwig-studio"
        cp "$desktop" $out/share/applications/
      done
    fi

    # 6. Copy icons
    if [ -d $out/usr/share/pixmaps ]; then
      mkdir -p $out/share/pixmaps
      cp -r $out/usr/share/pixmaps/* $out/share/pixmaps/
    fi
  '';
}
