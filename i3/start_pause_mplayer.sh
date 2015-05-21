#!/bin/bash


ps cax | grep mplayer > /dev/null
if [ $? -eq 0 ]; then
  echo "pause"
  echo "pause" > ~/.mplayer/fifo
else
  echo "play"
  mplayer -slave -input file=$HOME/.mplayer/fifo -loop -0 -shuffle $HOME/music/*.mp3
fi
