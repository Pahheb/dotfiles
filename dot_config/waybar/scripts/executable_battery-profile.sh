#!/bin/bash

current=$(powerprofilesctl list | grep '* ' | awk '{print $2}' | tr -d ':')

case "$current" in
"performance")
	powerprofilesctl set balanced
	;;
"balanced")
	powerprofilesctl set power-saver
	;;
"power-saver")
	powerprofilesctl set performance
	;;
esac
