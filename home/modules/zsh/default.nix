{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      up = "home-manager switch --flake $HOME/.dotfiles --impure -b backup";
      nos = "sudo nixos-rebuild switch --flake $HOME/.dotfiles#nixos";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" ];
      theme = "robbyrussell";
    };

    initContent = ''
      fastfetch
    '';
  };
}
