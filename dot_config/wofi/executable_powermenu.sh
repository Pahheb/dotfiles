#!/bin/bash

options="⏻ Shutdown
󰑙  Restart
󰤄  Sleep
❄ Hibernate
󰍃  Logout"

chosen=$(echo -e "$options" | wofi 	-c "$HOME/.config/wofi/config.powermenu" 	-C "$HOME/.config/wofi/style.powermenu.css" 	--dmenu)

case "$chosen" in
*"Shutdown")
	systemctl poweroff
	;;
*"Restart")
	systemctl reboot
	;;
*"Sleep")
	swaylock -f -c 000000 && systemctl suspend
	;;
*"Hibernate")
	systemctl hibernate
	;;
*"Logout")
	swaymsg exit
	;;
esac
