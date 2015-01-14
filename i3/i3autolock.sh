#!/bin/bash

# got this from: http://rabexc.org/posts/awesome-xautolock-battery
exec xautolock -detectsleep
  -time 1 -locker "i3lock -d -i ~/tmp/deb-locked.png" \
  -notify 30 \
  -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'"
