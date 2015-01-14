#!/bin/bash

# got this from: http://rabexc.org/posts/awesome-xautolock-battery
exec xautolock -detectsleep
  -time 1 -locker "i3lock -d -i ~/tmp/deb-locked.png" \
  -notify 30 \
  -notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'"

##############################
# This was the first version #
##############################
# The following 2 lines take a screenshot of the current desktop and blur it
#scrot ~/tmp/deb.png
#convert ~/tmp/deb.png -blur 2x2 ~/tmp/deb-locked.png
#i3lock -i ~/tmp/deb-locked.png
