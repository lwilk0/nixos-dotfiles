{
  config,
  lib,
  ...
}: {
  options.dotfiles.hyprland.environmentLua = lib.mkOption {
    type = lib.types.lines;
    default = "";
    description = "Host-specific Hyprland environment declarations.";
  };

  config.xdg.configFile."hypr/env.lua".text = config.dotfiles.hyprland.environmentLua;
}
