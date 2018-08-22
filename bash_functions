
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

# Following three functions were taken from this comment on quora:
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

# Automatically extract an archive
function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.xz)    tar Jxvf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       rar x $1       ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip -d `echo $1 | sed 's/\(.*\)\.zip/\1/'` $1;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "don't know how to extract '$1'" ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}
