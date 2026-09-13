{pkgs, ...}: {
  networking.firewall.checkReversePath = "loose";
  environment.systemPackages = with pkgs; [wireguard-tools proton-vpn];

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
    if (subject.isInGroup("networkmanager")) {
      var allowed = [
        "org.freedesktop.NetworkManager.enable-disable-wifi",
        "org.freedesktop.NetworkManager.enable-disable-wwan",
        "org.freedesktop.NetworkManager.network-control",
        "org.freedesktop.NetworkManager.wifi.scan",
        "org.freedesktop.NetworkManager.settings.modify.own",
      ];
      if (allowed.indexOf(action.id) >= 0) return polkit.Result.YES;
    }
  });
  '';
}
