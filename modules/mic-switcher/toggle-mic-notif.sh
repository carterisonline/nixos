#!/usr/bin/env bash
cd "$(dirname "$0")"

GAME_MUTED="$(pactl get-source-mute Game_Mic | awk '{print $2}')"

if [[ "$GAME_MUTED" == "no" ]]; then
    pw-play ../share/notification.ogg
fi