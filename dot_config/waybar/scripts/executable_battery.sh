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

# Estimated time remaining
charge_now=$(cat "$BAT/charge_now" 2>/dev/null || echo 0)
current_now=$(cat "$BAT/current_now" 2>/dev/null || echo 0)
charge_full=$(cat "$BAT/charge_full" 2>/dev/null || echo 0)

time_str="full"
if [ "$current_now" -gt 0 ] 2>/dev/null; then
	if [ "$status" = "Discharging" ]; then
		hours=$((charge_now * 100 / current_now))
		h=$((hours / 100))
		m=$(((hours % 100) * 60 / 100))
		time_str="${h}h ${m}m"
	elif [ "$status" = "Charging" ]; then
		remaining=$((charge_full - charge_now))
		if [ "$remaining" -gt 0 ]; then
			hours=$((remaining * 100 / current_now))
			h=$((hours / 100))
			m=$(((hours % 100) * 60 / 100))
			time_str="${h}h ${m}m"
		fi
	fi
fi

tooltip="Status: ${status} (${time_str})\nProfile: ${profile}"

echo "{\"text\": \"${icon}  ${capacity}%\", \"tooltip\": \"${tooltip}\", \"class\": \"${class}\"}"
