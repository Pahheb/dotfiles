#!/bin/bash

count=$(makoctl list | grep -c "^Notification")
if [ "$count" -gt 0 ]; then
    tooltip=$(makoctl list | grep 'summary:' | sed 's/.*summary: //')
    printf '{"text": " 󰦡 %s", "tooltip": "%s", "class": "has-notifications"}
' "$count" "$tooltip"
else
    echo '{"text": "󰦡", "tooltip": "No notifications", "class": "none"}'
fi
