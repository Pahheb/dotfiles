#!/bin/bash

if pgrep -x wlsunset >/dev/null; then
	pkill -x wlsunset
else
	wlsunset -T 3700 -t 3699 -S 00:00 -s 00:00 &
fi
