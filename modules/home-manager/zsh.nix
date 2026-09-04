{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -lh";
      la = "ls -lAh";
      lt = "ls -lAht";
      ".." = "cd ..";
      "..." = "cd ../..";


      up = "home-manager switch --flake $HOME/.dotfiles";
      nos = "sudo nixos-rebuild switch --flake $HOME/.dotfiles#nixos";
      nost = "sudo nixos-rebuild test --flake $HOME/.dotfiles#nixos";
      dots = "cd $HOME/.dotfiles";
      ndiff = "nix store diff-closures /run/current-system $(ls -d /nix/var/nix/profiles/system-* | tail -2 | head -1)";
      ns = "nix search nixpkgs";
      nsh = "nix shell nixpkgs#";

      cb = "cargo build";
      cbr = "cargo build --release";
      cr = "cargo run";
      crr = "cargo run --release";
      ct = "cargo test";
      cc = "cargo clippy -- -D warnings";
      cfix = "cargo clippy --fix";
      cfmt = "cargo fmt";
      cdoc = "cargo doc --open";
      ccheck = "cargo fmt && cargo clippy -- -D warnings && cargo test";

      gs = "git status";
      ga = "git add";
      gaa = "git add --all";
      gc = "git commit -m";
      gca = "git commit --amend --no-edit";
      gp = "git push";
      gpf = "git push --force-with-lease";
      gl = "git pull";
      glo = "git log --oneline --graph --decorate";
      gd = "git diff";
      gds = "git diff --staged";
      gco = "git checkout";
      gsw = "git switch";
      gbr = "git branch";

      guitar = "bash $HOME/.dotfiles/scripts/guitar.sh";
      unguitar = "bash $HOME/.dotfiles/scripts/unguitar.sh";
      jlsp = "pw-jack jack_lsp -c";
      pwnodes = "pw-cli list-objects Node | grep 'node.name'";
      sinks = "wpctl status | grep -A20 'Sinks:'";
      airpods = ''wpctl set-default $(wpctl status | awk '/AirPods Pro/{gsub(/\./,""); print $2}' | head -1)'';
      aux = ''wpctl set-default $(wpctl status | awk '/Built-in Audio Analog Stereo.*Sink/{gsub(/\./,""); print $2}' | head -1)'';

      cpu = "cat /proc/cpuinfo | grep 'model name' | head -1";
      temps = "cat /sys/class/hwmon/hwmon*/temp1_input 2>/dev/null | awk '{print $1/1000 \"°C\"}'";
      memf = "free -h";
      duf = "du -sh * | sort -h";

      ybs = "yabridgectl status";
      ybsync = "yabridgectl sync";

      grep = "grep --color=auto";
      mkdir = "mkdir -p";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -iv";
      clip = "wl-copy <";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "z" # jump to frecent directories with `z <partial-name>`
        "sudo" # press Esc twice to prepend sudo to the last command
        "rust" # cargo tab completions
        "systemd" # sc- aliases for systemctl
      ];
      theme = "robbyrussell";
    };

    # ── Extra init ─────────────────────────────────────────────────────────────
    initContent = ''
      fastfetch

      (( ''${+commands[direnv]} )) && eval "$(direnv hook zsh)"

      export JACK_DEFAULT_SERVER=pipewire
      export PATH="$HOME/.cargo/bin:$PATH"
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };
}
