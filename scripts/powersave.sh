#!/bin/sh

case $1/$2 in
  pre/*)
	/usr/bin/powersave false ;;
  post/*)
	sleep 1
	if cat /sys/class/power_supply/AC/online | grep 0 > /dev/null 2>&1
	then
		/usr/bin/powersave true
	else
		/usr/bin/powersave false
	fi
	;;
esac
