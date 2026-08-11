{config, ...}: {
  imports = [
    ./steam
    ./keyring
    ./bitwig
    ./gnupg
    ./protonvpn
    ./virtualbox
    ./k3b
    ./ollama
    ./nix-ld
    ./docker
    ./postgres
    ./librewolf
    ./wireshark
  ];
}
