{config, ...}: {
  imports = [
    ./steam
    ./keyring
    ./bitwig
    ./gnupg
    ./protonvpn
    ./k3b
    ./podman
    ./nix-ld
    ./librewolf
  ];
}
