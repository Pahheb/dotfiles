#!/bin/bash

# Wait for key release before triggering idle state
sleep 0.5

# Immediately trigger the existing swayidle's idle state.
# This runs all its configured timeout commands (lock + screen off).
# Any input will fire the resume commands (screen back on).
swayidle_pid=$(pgrep -x swayidle)
if [ -n "$swayidle_pid" ]; then
	kill -USR1 "$swayidle_pid"
fi
