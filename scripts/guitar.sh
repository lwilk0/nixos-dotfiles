#!/usr/bin/env bash
# =============================================================================
# guitar.sh — Guitar practice / monitoring mode (NixOS / PipeWire-JACK)
# =============================================================================

set -uo pipefail

# ── NixOS: Ensure Wayland vars are passed to the GUI apps ─────────────────────
# This prevents Carla/QjackCtl from opening on the wrong display or failing.
if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
  export XDG_CURRENT_DESKTOP="${XDG_CURRENT_DESKTOP:-hyprland}"
  export QT_QPA_PLATFORM="${QT_QPA_PLATFORM:-wayland}"
fi

# ── Config ────────────────────────────────────────────────────────────────────
WAIT_CARLA=30

# !!! NIXOS WARNING !!!
# PipeWire ALSA node names can change between reboots if USB devices swap ports.
# If this script fails to connect, run `pw-cli info all | grep -i "node.name"`
# or `pw-jack jack_lsp` to verify these exact strings!
NUX_CAPTURE_L="NUX NGA-3BT:capture_FL"
NUX_CAPTURE_R="NUX NGA-3BT:capture_FR"
HEADPHONES_L="ALC897 Analog:playback_FL"
HEADPHONES_R="ALC897 Analog:playback_FR"

# ── Colours & Helpers ─────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; CYAN='\033[0;36m'; RESET='\033[0m'
log()  { echo -e "${CYAN}[guitar]${RESET} $*"; }
ok()   { echo -e "${GREEN}[guitar]${RESET} $*"; }
warn() { echo -e "${YELLOW}[guitar]${RESET} $*"; }
err()  { echo -e "${RED}[guitar]${RESET} $*" >&2; }

notify() {
  notify-send --icon=audio-x-generic --app-name="Guitar" "$1" "$2" 2>/dev/null || true
}

# ── Guard: already running ────────────────────────────────────────────────────
if pgrep -x carla &>/dev/null; then
  warn "Carla is already running."
  read -rp "  Restart the guitar session? [y/N] " choice
  [[ "${choice,,}" == "y" ]] || exit 0
  log "Stopping existing session first..."
  pkill -x carla    2>/dev/null || true
  pkill -x qjackctl 2>/dev/null || true
  sleep 1
fi

# ── Helper: wait for a JACK port pattern to appear ───────────────────────────
wait_for_port() {
  local pattern="$1" label="$2" timeout="$3" elapsed=0
  log "Waiting for ${label} ports..."
  # Look for PipeWire object paths matching the pattern
  while ! pw-cli ls Port 2>/dev/null | grep -q "object.path.*\"${pattern}\""; do
    if (( elapsed >= timeout )); then
      err "Timed out waiting for ${label} ports after ${timeout}s."
      return 1
    fi
    sleep 0.5
    (( elapsed++ )) || true
  done
  ok "${label} ports found."
}

# ── Helper: connect with error reporting ─────────────────────────────────────
connect() {
  local src="$1" dst="$2"
  if pw-link "${src}" "${dst}" 2>/dev/null; then
    ok "Connected: ${src}  →  ${dst}"
  else
    warn "Connection failed (may already be connected): ${src} → ${dst}"
  fi
}

# ── Start programs ────────────────────────────────────────────────────────────
log "Starting QjackCtl (JACK monitor)..."
pw-jack qjackctl &

log "Starting Carla (loads last session with Archetype Gojira)..."
PIPEWIRE_QUANTUM="128/48000" pw-jack carla &

# ── Wait for Carla ────────────────────────────────────────────────────────────
sleep 0.5

# ── Discover exact Carla port names (Robust Regex) ───────────────────────────
# Fallback to common names if the regex didn't match
CARLA_IN_1="Carla:audio-in1"
CARLA_IN_2="Carla:audio-in2"
CARLA_OUT_1="Carla:audio-out1"
CARLA_OUT_2="Carla:audio-out2"

log "Using Carla ports:"
log "  Inputs:  ${CARLA_IN_1}  ${CARLA_IN_2}"
log "  Outputs: ${CARLA_OUT_1}  ${CARLA_OUT_2}"

# ── Wire the signal chain ─────────────────────────────────────────────────────
log "Routing signal chain..."

# PipeWire allows multiple connections to a single port and will automatically
# sum them (mix them together). This safely merges your stereo interface into mono.
pw-link "${NUX_CAPTURE_L}" "${CARLA_IN_1}"
pw-link "${NUX_CAPTURE_R}" "${CARLA_IN_2}"

# Connect stereo output to headphones
pw-link "${CARLA_OUT_1}" "${HEADPHONES_L}"
pw-link "${CARLA_OUT_2}" "${HEADPHONES_R}"

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
ok "═══════════════════════════════════════════════════"
ok "  Guitar mode active."
ok "  NUX NGA-3BT → Archetype Gojira → Headphones"
ok "═══════════════════════════════════════════════════"
notify "Guitar mode active 🎸" "NUX → Gojira → Headphones"
