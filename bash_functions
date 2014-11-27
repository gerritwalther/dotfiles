
# Sets the title of the current terminal
set_title() {
  ORIG=$PS1
  TITLE="\e]2;$*\a"
  PS1=${ORIG}${TITLE}
}
