{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "librewolf-perf" ''
      # 1. Force Wayland and unlock AMD Hardware Video Decoding
      export MOZ_ENABLE_WAYLAND=1
      export MOZ_DISABLE_RDD_SANDBOX=1 
      export LIBVA_DRIVER_NAME=radeonsi
      export EGL_PLATFORM=wayland

      # 2. Let CachyOS scheduler handle CPU threads (Removed taskset)
      exec ${librewolf}/bin/librewolf \
        --setpref='media.ffmpeg.vaapi.enabled:true' \
        --setpref='layers.acceleration.force-enabled:true' \
        --setpref='webgl.force-enabled:true' \
        --setpref='gfx.webrender.all:true' \
        --setpref='dom.ipc.processCount:16' \
        "$@"
    '')
  ];
}