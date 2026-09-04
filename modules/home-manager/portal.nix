{ config, pkgs, ... }:

{
  services.gnome-keyring = {
    components = [ "pkcs11" "secrets" "ssh" ];
  };

  xdg.portal = {
    enable = true;
  };
}
