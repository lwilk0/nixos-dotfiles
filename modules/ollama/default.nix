{ pkgs-unstable, ...}: {
  environment.systemPackages = [ pkgs-unstable.ollama-rocm ];

  services.ollama = {
    enable = true;
    # Point to the unstable package which includes ROCm 7.x (RDNA 4 support)
    package = pkgs-unstable.ollama-rocm; 
    host = "0.0.0.0";
    port = 11434;

    user = "ollama";
    group = "ollama";
    
    # Add the override just in case
    rocmOverrideGfx = "12.0.0";
  };

  users.users.ollama = {
    isSystemUser = true;
    group = "ollama";
    extraGroups = [ "video" "render" ];
  };

  services.open-webui = { enable = false; };
}