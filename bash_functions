
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
