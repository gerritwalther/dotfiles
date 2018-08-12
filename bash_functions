
# Sets the title of the current terminal
set_title() {
  ORIG=$PS1
  TITLE="\e]2;$*\a"
  PS1=${ORIG}${TITLE}
}

# Mkdir and cd into the same in one command
function mkdircd() {
  mkdir -p "$@" && eval cd "\"\$$#\"";
}

# Add some functions:
# http://qr.ae/TUIjb7

# Move up x folders, where x is the parameter or by default 1
function up() {
  if [ $# -eq 0 ]; then
    times=1
  else
    times=$1
  fi
  while [ "$times" -gt "0" ]; do
    cd ..
    times=$(($times - 1))
  done
}

# Get current weather for current location or specified location
weather(){
  curl -s "wttr.in/$1?m1"
}
