{ lib, fetchurl, appimageTools }:
let
  pname = "hydra";
  version = "3.9.5";

  src = fetchurl {
    url = "https://github.com/hydralauncher/hydra/releases/download/v${version}/hydralauncher-${version}.AppImage";
    sha256 = "045cpjj3pbq195ynixxlvdfsrh24mz8p661nxcx0sal6wy9pjl8l";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in 
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/hydralauncher.desktop $out/share/applications/${pname}.desktop
    install -m 444 -D ${appimageContents}/hydralauncher.png $out/share/icons/hicolor/512x512/apps/${pname}.png
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname} %U'
  '';

  meta = with lib; {
    description = "Hydra game launcher";
    homepage = "https://hydralauncher.gg/";
    license = licenses.mit;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
  };
}
