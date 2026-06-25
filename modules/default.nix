{config, ...}: {
  imports = [
    ./steam
    ./brave
    ./keyring
    ./bitwig
    ./gnupg
    ./protonvpn
    ./virtualbox
    ./k3b
    ./nix-ld
  ];
}
