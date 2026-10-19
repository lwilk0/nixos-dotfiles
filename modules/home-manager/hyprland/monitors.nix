{
  config,
  lib,
  ...
}: {
  options.dotfiles.hyprland.monitorsLua = lib.mkOption {
    type = lib.types.lines;
    default = "";
    description = "Host-specific Hyprland monitor declarations.";
  };

  config.xdg.configFile."hypr/monitors.lua".text = config.dotfiles.hyprland.monitorsLua;
}
