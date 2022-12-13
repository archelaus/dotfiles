#/usr/bin/env bash

polybar-msg cmd quit || killall -q polybar
polybar example --config=~/.config/polybar/config.ini >/tmp/polybar.log 2>&1 &

echo "Bars launched..."
