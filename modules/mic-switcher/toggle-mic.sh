#!/usr/bin/env bash

CALL_MUTED="$(pactl get-source-mute Call_Mic | awk '{print $2}')"

if [[ "$CALL_MUTED" == "no" ]]; then
    pactl set-source-mute Call_Mic 1
    pactl set-source-mute Game_Mic 0
else
    pactl set-source-mute Call_Mic 0
    pactl set-source-mute Game_Mic 1
fi