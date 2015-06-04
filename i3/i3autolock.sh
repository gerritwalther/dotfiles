#!/bin/bash

# got this from: http://rabexc.org/posts/awesome-xautolock-battery
# add -d to i3lock to set screen to standby directly
exec xautolock -corners 0-000 -detectsleep -time 3 -locker "sh ~/.i3/i3lock.sh" -notify 30 -notifier "notify-send --urgency=critical 'LOCKING screen in 30 seconds'"
