{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin "librewolf-perf" ''
      exec ${util-linux}/bin/taskset -c 0-11 ${librewolf}/bin/librewolf \
        --new-instance \
        --setpref='media.ffmpeg.vaapi.enabled:true' \
        --setpref='layers.acceleration.force-enabled:true' \
        --setpref='webgl.force-enabled:true' \
        --setpref='gfx.webrender.all:true' \
        --setpref='dom.ipc.processCount:8' \
        --setpref='browser.cache.disk.enable:false' \
        --setpref='browser.cache.memory.enable:true' \
        "$@"
    '')
  ];
}
