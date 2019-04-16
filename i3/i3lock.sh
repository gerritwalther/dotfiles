#!/bin/bash

# The following 2 lines take a screenshot of the current desktop and blur it
#scrot ~/tmp/deb.png
#convert ~/tmp/deb.png -blur 2x2 ~/tmp/deb-locked.png

# -i for a specific image to show, -t to show it on all monitors
i3lock -i $(find ~/Pictures/wp/ -type f -name "*.png" | shuf -n 1) -t