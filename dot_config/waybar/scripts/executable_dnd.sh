#!/bin/bash

if makoctl mode | grep -q "do-not-disturb"; then
    echo '{"text": "󰂛", "tooltip": "activated", "class": "dnd-on"}'
else
    echo '{"text": "󰂚", "tooltip": "deactivated", "class": "dnd-off"}'
fi
