#!/bin/bash

if pgrep -x wlsunset >/dev/null; then
	echo '{"text": "󰌵", "tooltip": "Blue light filter ON", "class": "wlsunset-on"}'
else
	echo '{"text": "󰹏", "tooltip": "Blue light filter OFF", "class": "wlsunset-off"}'
fi
