{ config, pkgs, ... }:
{
  programs.zsh = {
    enable              = true;
    enableCompletion    = true;
    autosuggestion.enable      = true;
    syntaxHighlighting.enable  = true;

    # ── Shell aliases ──────────────────────────────────────────────────────────
    shellAliases = {
      # ── Navigation ────────────────────────────────────────────────────────
      ll  = "ls -lh";
      la  = "ls -lAh";
      lt  = "ls -lAht";           # sort by modified time
      ".." = "cd ..";
      "..." = "cd ../..";

      # ── NixOS / Home Manager ───────────────────────────────────────────────
      # Rebuild home config (most common — no sudo needed)
      up   = "home-manager switch --flake $HOME/.dotfiles";
      # Rebuild full NixOS system
      nos  = "sudo nixos-rebuild switch --flake $HOME/.dotfiles#nixos";
      # Test a system change without making it the boot default
      nost = "sudo nixos-rebuild test --flake $HOME/.dotfiles#nixos";
      # Jump into dotfiles quickly
      dots = "cd $HOME/.dotfiles";
      # Show what changed since last switch
      ndiff = "nix store diff-closures /run/current-system $(ls -d /nix/var/nix/profiles/system-* | tail -2 | head -1)";
      # Search nixpkgs
      ns  = "nix search nixpkgs";
      # Open a temporary shell with a package without installing it
      nsh = "nix shell nixpkgs#";

      # ── Rust / Cargo ──────────────────────────────────────────────────────
      cb   = "cargo build";
      cbr  = "cargo build --release";
      cr   = "cargo run";
      crr  = "cargo run --release";
      ct   = "cargo test";
      cc   = "cargo clippy -- -D warnings";
      cfix = "cargo clippy --fix";
      cfmt = "cargo fmt";
      cdoc = "cargo doc --open";
      # Full release check (fmt + clippy + test) before publishing
      ccheck = "cargo fmt && cargo clippy -- -D warnings && cargo test";

      # ── Git ───────────────────────────────────────────────────────────────
      gs  = "git status";
      ga  = "git add";
      gaa = "git add --all";
      gc  = "git commit -m";
      gca = "git commit --amend --no-edit";
      gp  = "git push";
      gpf = "git push --force-with-lease";
      gl  = "git pull";
      glo = "git log --oneline --graph --decorate";
      gd  = "git diff";
      gds = "git diff --staged";
      gco = "git checkout";
      gsw = "git switch";
      gbr = "git branch";

      # ── Pro audio ─────────────────────────────────────────────────────────
      # Start the full guitar chain (NUX → Carla/Archetype Gojira → headphones)
      guitar   = "bash $HOME/.dotfiles/scripts/guitar.sh";
      # Tear down the guitar session cleanly
      unguitar = "bash $HOME/.dotfiles/scripts/unguitar.sh";
      # Show current JACK port connections
      jlsp  = "pw-jack jack_lsp -c";
      # List all PipeWire nodes (useful for debugging routing)
      pwnodes = "pw-cli list-objects Node | grep 'node.name'";
      # Quick sink switcher — print available sinks then set one by index
      sinks = "wpctl status | grep -A20 'Sinks:'";
      # Swap to AirPods (for videos / music)
      airpods = ''wpctl set-default $(wpctl status | awk '/AirPods Pro/{gsub(/\./,""); print $2}' | head -1)'';
      # Swap to built-in audio (for guitar monitoring through headphones on aux)
      aux = ''wpctl set-default $(wpctl status | awk '/Built-in Audio Analog Stereo.*Sink/{gsub(/\./,""); print $2}' | head -1)'';

      # ── Gaming ────────────────────────────────────────────────────────────
      # Launch Steam with gamemode active
      steam     = "gamemoderun steam";
      # Print current AMD GPU power profile (0=default, 1=3D_FULL_SCREEN, etc.)
      gpuprofile = "cat /sys/class/drm/card1/device/pp_power_profile_mode | grep '*'";

      # ── System info ───────────────────────────────────────────────────────
      btop  = "btop";
      cpu   = "cat /proc/cpuinfo | grep 'model name' | head -1";
      temps = "cat /sys/class/hwmon/hwmon*/temp1_input 2>/dev/null | awk '{print $1/1000 \"°C\"}'";
      memf  = "free -h";
      # Disk usage (human-readable, sorted by size)
      duf   = "du -sh * | sort -h";

      # ── Yabridge ──────────────────────────────────────────────────────────
      ybs   = "yabridgectl status";
      ybsync = "yabridgectl sync";

      # ── Misc ──────────────────────────────────────────────────────────────
      cat   = "bat --style=plain";            # nicer cat (if bat is installed)
      grep  = "grep --color=auto";
      mkdir = "mkdir -p";
      cp    = "cp -iv";
      mv    = "mv -iv";
      rm    = "rm -iv";
      # Copy file contents to clipboard (Wayland)
      clip  = "wl-copy <";
    };

    oh-my-zsh = {
      enable  = true;
      plugins = [
        "git"
        "z"          # jump to frecent directories with `z <partial-name>`
        "sudo"       # press Esc twice to prepend sudo to the last command
        "rust"       # cargo tab completions
        "systemd"    # sc- aliases for systemctl
      ];
      theme = "robbyrussell";
    };

    # ── Extra init ─────────────────────────────────────────────────────────────
    initContent = ''
      # Show system info on new terminal (provided by the kitty startup session
      # which already runs caelestia colour sequences first)
      fastfetch

      # ── direnv hook ─────────────────────────────────────────────────────────
      # home-manager's programs.direnv sets this up, but an explicit hook here
      # ensures it runs even if direnv wasn't activated through home-manager.
      (( ''${+commands[direnv]} )) && eval "$(direnv hook zsh)"

      # ── JACK / pw-jack helper ────────────────────────────────────────────────
      # Ensure pw-jack is always used when launching JACK-aware apps from the
      # terminal.  This is a no-op when JACK is already running.
      export JACK_DEFAULT_SERVER=pipewire

      # ── Cargo / Rust ────────────────────────────────────────────────────────
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
  };
}
