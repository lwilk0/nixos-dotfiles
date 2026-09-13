#!/usr/bin/env bash

ACTIVE_TITLE=$(hyprctl activewindow -j | jq -r '.title')
[ -z "$ACTIVE_TITLE" ] || [ "$ACTIVE_TITLE" = "null" ] && exit 0
hyprctl dispatch 'hl.dsp.window.close()'