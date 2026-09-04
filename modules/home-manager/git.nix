{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    settings.user = {
      name = "Luke Wilkinson";
      email = "wilkinsonluke@proton.me";
    };
  }; 
}
