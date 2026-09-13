{ pkgs, ... }: {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };
  environment.systemPackages = [ pkgs.gnupg ];
}