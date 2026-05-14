{pkgs, ...}: {
  networking.firewall.checkReversePath = false;
  environment.systemPackages = with pkgs; [wireguard-tools protonvpn-gui];

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        action.id.indexOf("org.freedesktop.NetworkManager.") === 0 &&
        subject.isInGroup("networkmanager")
      ) {
        return polkit.Result.YES;
      }
    });
  '';
}
