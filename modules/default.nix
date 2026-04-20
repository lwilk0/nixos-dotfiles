{ config, ... }:
{
  imports = [
    ./steam
    ./brave
    ./mullvad
    ./bitwig
    ./gnupg
  ];
}
