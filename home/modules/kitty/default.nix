{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    extraConfig = ''
      startup_session startup.session
    '';
  };

  xdg.configFile."kitty/startup.session".text = ''
    launch sh -c "cat ~/.local/state/caelestia/sequences.txt 2> /dev/null; exec $SHELL"
  '';
}
