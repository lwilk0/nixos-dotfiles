#!/usr/bin/env bash
MODE_FILE="/tmp/minikb_mode"
MIDI_STATE_DIR="/tmp/minikb_midi_state" # Directory to store on/off states
MIDI_PORT="hw:3,0,0"

# Initialize mode file if it doesn't exist
if [ ! -f "$MODE_FILE" ]; then
  echo "media" >"$MODE_FILE"
fi

# Initialize MIDI state directory
if [ ! -d "$MIDI_STATE_DIR" ]; then
  mkdir -p "$MIDI_STATE_DIR"
fi

CURRENT_MODE=$(cat "$MODE_FILE")

# If called with "switch", cycle to the next mode
if [ "$1" == "switch" ]; then
  case "$CURRENT_MODE" in
  media) echo "workspace" >"$MODE_FILE" ;;
  workspace) echo "window" >"$MODE_FILE" ;;
  window) echo "app" >"$MODE_FILE" ;;
  app) echo "midi" >"$MODE_FILE" ;;
  midi) echo "media" >"$MODE_FILE" ;;
  esac
  exit 0
fi

ACTION=$1

# --- Helper function to toggle B0 Control Change messages ---
# Arguments: $1 = button_name (for state file), $2 = CC_number (hex)
toggle_midi() {
  local btn="$1"
  local cc="$2"
  local state_file="$MIDI_STATE_DIR/$btn"

  # Default to 0 (Off) if file doesn't exist
  local current_state="0"
  if [ -f "$state_file" ]; then
    current_state=$(cat "$state_file")
  fi

  if [ "$current_state" == "0" ]; then
    # Was OFF, send ON (Value 7F)
    # Syntax: B0 (CC Ch1) + CC Number + 7F (127)
    amidi -p "$MIDI_PORT" -S "B0 $cc 7F"
    echo "1" >"$state_file"
  else
    # Was ON, send OFF (Value 00)
    # Syntax: B0 (CC Ch1) + CC Number + 00 (0)
    amidi -p "$MIDI_PORT" -S "B0 $cc 00"
    echo "0" >"$state_file"
  fi
}

nux_step() {
  local step="$1"  # e.g. 5%+ or 10%-
  local id
  id="$(wpctl status | awk '/^ *[0-9]+\\. alsa_output\\.usb-NUX_NUX_NGA-3BT_.*\\.analog-stereo/ {print $1; exit}')"
  [ -n "$id" ] || { echo "NUX sink not found"; return 1; }
  wpctl set-volume "$id" "$step"
}
# -------------------------------------------------------------

case "$CURRENT_MODE" in
media)
  case "$ACTION" in
  w) playerctl play-pause ;;
  a) playerctl previous ;;
  s) playerctl next ;;
  d) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
  up) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
  down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
  esac
  ;;
workspace)
  case "$ACTION" in
  w) hyprctl dispatch workspace 1 ;;
  a) hyprctl dispatch workspace 2 ;;
  s) hyprctl dispatch workspace 3 ;;
  d) hyprctl dispatch workspace 4 ;;
  up) hyprctl dispatch workspace +1 ;;
  down) hyprctl dispatch workspace -1 ;;
  esac
  ;;
window)
  case "$ACTION" in
  w) hyprctl dispatch killactive ;;
  a) hyprctl dispatch togglefloating ;;
  s) hyprctl dispatch fullscreen ;;
  d) hyprctl dispatch centerwindow 1 ;;
  up) hyprctl dispatch movefocus r ;;
  down) hyprctl dispatch movefocus l ;;
  esac
  ;;
app)
  case "$ACTION" in
  w) kitty & ;;
  a) brave & ;;
  s) discord & ;;
  d) kitty -- yazi-themed & ;;
  up) hyprctl dispatch cyclenext ;;
  down) hyprctl dispatch cyclenext prev ;;
  esac
  ;;
midi)
  case "$ACTION" in
  # Pass button name and CC Number to the toggle function
  w) toggle_midi "w" "00" ;;
  a) toggle_midi "a" "01" ;;
  s) toggle_midi "s" "04" ;;
  d) toggle_midi "d" "03" ;;
  #up) amidi -p "$MIDI_PORT" -S "B0 01 7F" ;;
  #down) amidi -p "$MIDI_PORT" -S "B0 01 00" ;;
  up) nux_step 5%+ ;;
  up) nux_step 5%- ;;
  esac
  ;;
esac
