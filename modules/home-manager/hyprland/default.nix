{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./settings.nix
    ./binds.nix
    ./rules.nix
    ./monitors.nix
    ./env.nix
    ./colours.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;

    /*
      systemd = {
      enable = true;
      variables = ["--all"];
    };
    */
  };

  xdg.configFile."hypr/hyprland.lua".text = ''
    require("env")
    require("monitors")
    require("settings")
    require("scheme.default")
    require("rules")
    require("binds")
  '';
}
