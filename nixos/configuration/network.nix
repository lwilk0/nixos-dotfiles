{...}: {
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
    wifi.powersave = false;
  };
  networking.wireless.iwd.enable = true;
  boot.extraModprobeConfig = ''
    options rtw89_core disable_ps_mode=y
    options rtw89_pci  disable_aspm_l1=y disable_aspm_l1ss=y disable_clkreq=y
  '';
}
