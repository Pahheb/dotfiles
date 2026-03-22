#!/bin/bash

BAT="/sys/class/power_supply/BAT1"
capacity=$(cat "$BAT/capacity" 2>/dev/null || echo 0)
status=$(cat "$BAT/status" 2>/dev/null || echo "Unknown")
profile=$(powerprofilesctl list | grep '* ' | awk '{print $2}' | tr -d ':')

# Battery icons (0-100%, same as waybar built-in)
icons=("󱃍" "󰁺" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
idx=$((capacity / 11))
if [ "$idx" -gt 9 ]; then idx=9; fi
icon=${icons[$idx]}

# Charging icon
if [ "$status" = "Charging" ]; then
	icon="󰂄"
fi

# Class for styling
class="normal"
if [ "$capacity" -le 15 ]; then
	class="critical"
elif [ "$capacity" -le 30 ]; then
	class="warning"
fi

tooltip="Status: ${status}\nProfile: ${profile}"

echo "{\"text\": \"${icon}  ${capacity}%\", \"tooltip\": \"${tooltip}\", \"class\": \"${class}\"}"
