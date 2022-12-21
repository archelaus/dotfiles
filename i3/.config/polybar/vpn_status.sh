#!/usr/bin/dash

nmcli c show --active | rg -q tun && echo "%{F#61C766}"
