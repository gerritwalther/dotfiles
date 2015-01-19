#!/bin/bash

# got this from: http://rabexc.org/posts/awesome-xautolock-battery
# add -d to i3lock to set screen to standby directly
exec xautolock -detectsleep -time 3 -locker ./i3lock.sh -notify 30 -notifier "notify-send -urgency=critical 'LOCKING screen in 30 seconds'"
