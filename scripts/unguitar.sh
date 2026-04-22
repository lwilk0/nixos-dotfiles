#!/usr/bin/env bash
# Gracefully stop the guitar routing session

echo -e "\033[0;36m[guitar]\033[0m Tearing down session..."
pkill -x carla 2>/dev/null && echo -e "\033[0;32m[guitar]\033[0m Killed Carla." || true
pkill -x .qjackctl-wrapp 2>/dev/null && echo -e "\033[0;32m[guitar]\033[0m Killed QjackCtl." || true

# Optional: destroy specific PipeWire link nodes if they linger (usually not needed)
# pw-cli destroy <node-id>

notify-send --icon=audio-x-generic --app-name="Guitar" "Session stopped" "Carla and routing closed."
echo -e "\033[0;32m[guitar]\033[0m Done."
