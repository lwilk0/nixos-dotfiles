{ lib, pkgs, config, ... }:
let
  cfg = config.services.dotfilesAutosync;

  syncScript = pkgs.writeShellApplication {
    name = "dotfiles-autosync";
    runtimeInputs = with pkgs; [ git coreutils openssh ];
    text = ''
      set -uo pipefail

      DOT_DIR="''${HOME}/.dotfiles"
      AUTO_BRANCH="${cfg.branch}"
      REMOTE="${cfg.remote}"

      [ -d "$DOT_DIR/.git" ] || { echo "Not a git repo: $DOT_DIR"; exit 0; }
      cd "$DOT_DIR"

      # Never stop in-progress git operations
      if [ -d .git/rebase-merge ] || [ -d .git/rebase-apply ]; then
        echo "Rebase in progress; skipping."; exit 0
      fi
      [ -f .git/MERGE_HEAD ] && { echo "Merge in progress; skipping."; exit 0; }
      [ -f .git/CHERRY_PICK_HEAD ] && { echo "Cherry-pick in progress; skipping."; exit 0; }

      CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")

      if [ "$CURRENT_BRANCH" != "$AUTO_BRANCH" ]; then
        echo "Currently on ''${CURRENT_BRANCH:-detached}; switching to $AUTO_BRANCH"
        git stash push -u -m "autosync-stash-$(date +%s)" 2>/dev/null || true
        if git show-ref --verify --quiet "refs/heads/$AUTO_BRANCH"; then
          git checkout "$AUTO_BRANCH"
        else
          git checkout -b "$AUTO_BRANCH"
        fi
      fi

      export GIT_AUTHOR_NAME="${cfg.authorName}"
      export GIT_AUTHOR_EMAIL="${cfg.authorEmail}"
      export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
      export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

      git add -A

      # Don't spam the remote with empty commits.
      if git diff --cached --quiet HEAD --; then
        echo "No changes to sync."
        exit 0
      fi

      git -c commit.gpgsign=false commit \
        -m "[autosync] snapshot at $(date -u +%Y-%m-%dT%H:%M:%SZ)"

      if ! git push --force-with-lease "$REMOTE" "$AUTO_BRANCH"; then
        echo "Push failed (remote moved or first push). Fetching and retrying..."
        git fetch "$REMOTE" "$AUTO_BRANCH" 2>/dev/null || true
        git push --force-with-lease "$REMOTE" "$AUTO_BRANCH" \
          || { echo "Push still failing; leaving for manual resolution."; exit 1; }
      fi
    '';
  };
in {
  options.services.dotfilesAutosync = {
    enable = lib.mkEnableOption "automatic dotfiles sync to a side branch";

    branch = lib.mkOption {
      type = lib.types.str;
      default = "auto-sync";
      description = "Branch name for automatic commits.";
    };

    remote = lib.mkOption {
      type = lib.types.str;
      default = "origin";
      description = "Git remote to push to.";
    };

    interval = lib.mkOption {
      type = lib.types.str;
      default = "2h";
      example = "30min";
      description = ''
        systemd OnUnitActiveSec value (runs this long after the last activation).
        Use "2h" for hours, "30min" for minutes etc.
      '';
    };

    startBootSec = lib.mkOption {
      type = lib.types.str;
      default = "5min";
      description = "Delay before the first run after boot.";
    };

    authorName = lib.mkOption {
      type = lib.types.str;
      default = "dotfiles-autosync";
      description = "Git author identity for auto-commits (so you can filter them).";
    };

    authorEmail = lib.mkOption {
      type = lib.types.str;
      default = "autosync@localhost";
      description = "Git author email for auto-commits.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.timers.dotfiles-autosync = {
      Unit.Description = "Auto-sync dotfiles to side branch";
      Install.WantedBy = [ "timers.target" ];
      Timer = {
        OnBootSec      = cfg.startBootSec;
        OnUnitActiveSec = cfg.interval;
        Unit           = "dotfiles-autosync.service";
        Persistent = true;
      };
    };

    systemd.user.services.dotfiles-autosync = {
      Unit = {
        Description = "Auto-sync dotfiles to side branch";
        RefuseManualStart = false;
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${syncScript}/bin/dotfiles-autosync";
      };
    };
  };
}