#!/bin/bash

## DESCRIPTION: Install script for the dotfiles project.
## AUTHOR:      Gerrit Walther
## USAGE:       Execute from dotfiles-project directory:
##              ./install.sh <options to install>

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

usage () {
cat <<EOF
Usage: $0 [options]

Installs the config files and folders of this dotfiles-project.

At least one of the following options is required.

-h | --help          this usage.
-v | --verbose       More output for debugging

-a | --all           Installs all of the following config files.
-b | --bash   <host> Installs the bash files. <host> will be used to link to local bash stuff (e.g. 'work' or 'home').
-d | --dunst         Installs the dunst config files.
-g | --git           Installs the git config files.
-i | --i3wm          Installs all i3wm config and script files.
-s | --ssh           Installs the ssh config files.
-t | --terminator    Installs the terminator config files.

EOF
  exit 1
}

log_debug () {
  if $VERBOSE ; then
    echo "$@"
  fi
}

backup () {
  if [ -e $1 -a ! -h $1 ]; then
    log_debug Backing up current $1 ...
    mv $1 $1-bak
    log_debug Backed up current $1 to $1-bak .
  else
    log_debug Not backing up $1 because it is not existent or a symlink.
  fi
}

_symlink () {
  log_debug Symlinking $2 to $1 ...
  ln -s $1 $2
  log_debug Symlinked $2 to $1.
}

## Call this after backup, as it does not remove existent files/directories, only symlinks
## $1 is the link, $2 the link_name 
symlink_with_debug () {
  if [ -h $2 -a `realpath $2` == $1 ]; then
    log_debug Not symlinking because symlink is already set.
  elif [ -h $2 ]; then
    log_debug Removing symlink $2 ...
    rm $2
    log_debug Removed symlink $2 .
    _symlink $1 $2
  elif [ ! -e $2 ]; then
    _symlink $1 $2
  fi
}

check_dir () {
  if [ ! -d $1 ] ; then
    log_debug $1 not existent. Creating it...
    mkdir -p $1
    log_debug Created $1.
  fi
}

install_git () {
  echo Installing gitconfig to $HOME ...

  backup $HOME/.gitconfig

  symlink_with_debug $PWD/gitconfig $HOME/.gitconfig

  echo Git is installed. You might want to copy your user settings from $HOME/gitconfig.bak to $HOME/.gituser
}

install_ssh () {
  echo Copying sample config file to $HOME/.ssh/config ...

  backup $HOME/.ssh/config

  log_debug Copying dotfiles .ssh/config ...
  cp $PWD/ssh/config $HOME/.ssh/config
  log_debug Copied dotfiles .ssh/config.

  echo Copied ssh file. You should adjust it now, to avoid errors.
}

install_i3 () {
  #TODO: call generate script for the i3/config file (needs to be implemented)
  if [ -h $HOME/.i3 ]; then
    if [ `realpath $HOME/.i3` == $PWD/i3 ]; then
      echo i3 already installed.
    else
      rm $HOME/.i3
      symlink_with_debug PWD/i3 $HOME/.i3
      echo Installed i3.
    fi
  else
    echo Installing i3...
    if [ -e $HOME/.i3 ]; then
      mv $HOME/.i3 $HOME/.i3-bak
    fi
    symlink_with_debug $PWD/i3 $HOME/.i3
    echo Installed i3.
  fi
}

install_bash () {
  log_debug Backing up bash files...
  backup $HOME/.bash_aliases
  backup $HOME/.bash_functions
  backup $HOME/.bash_$HOST
  backup $HOME/.bash_profile
  backup $HOME/.bashrc
  log_debug Backed up bash files.

  log_debug Symlinking bash files...
  symlink_with_debug $PWD/bash_aliases $HOME/.bash_aliases
  symlink_with_debug $PWD/bash_functions $HOME/.bash_functions
  symlink_with_debug $PWD/bash_$HOST $HOME/.bash_custom
  symlink_with_debug $PWD/bash_profile $HOME/.bash_profile
  symlink_with_debug $PWD/bashrc $HOME/.bashrc
  log_debug Symlinked bash files.
}

install_dunst () {
  check_dir $HOME/.config/dunst

  if [ ! -h $HOME/.config/dunst/dunstrc ] ; then
    backup $HOME/.config/dunst/dunstrc
  fi

  symlink_with_debug $PWD/config/dunst/dunstrc $HOME/.config/dunst/dunstrc
}

install_terminator () {
  check_dir $HOME/.config/terminator

  if [ ! -h $HOME/.config/terminator/config ] ; then
    backup $HOME/.config/terminator/config
  fi

  symlink_with_debug $PWD/config/terminator/config $HOME/.config/terminator/config
}

install_all () {
  install_bash
  install_dunst
  install_git
  install_i3
  install_ssh
  install_terminator
}

# Got this from http://stackoverflow.com/a/7948533/1004795
TEMP=`getopt -o vgsib:dtah --long verbose,git,ssh,i3wm,bash:,dunst,terminator,all,help \
             -n 'install.sh' -- "$@"`

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Stop here, if no arguments were passed
if [ -z $1 ] ; then usage; fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

ALL=false
BASH=false
DUNST=false
GIT=false
I3=false
SSH=false
TERMINATOR=false
VERBOSE=false

HOST=$(cat "$PWD/host")

while true; do
  case "$1" in
    -h | --help       ) usage ;;
    -a | --all        ) ALL=true; shift ;;
    -b | --bash       ) BASH=true; HOST="$2"; shift 2 ;;
    -d | --dunst      ) DUNST=true; shift ;;
    -g | --git        ) GIT=true; shift ;;
    -i | --i3wm       ) I3=true; shift ;;
    -s | --ssh        ) SSH=true; shift ;;
    -t | --terminator ) TERMINATOR=true; shift ;;
    -v | --verbose    ) VERBOSE=true; shift ;;
    -- ) shift; break ;;
    *  ) break ;;
  esac
done

if $VERBOSE ; then
  log_debug Activating verbose logging!\n\n
fi

if ! $ALL ; then
  if $GIT ; then
    install_git
  fi
  if $SSH ; then
    install_ssh
  fi
  if $I3 ; then
    install_i3
  fi
  if $BASH ; then
    install_bash
  fi
  if $DUNST ; then
    install_dunst
  fi
  if $TERMINATOR ; then
    install_terminator
  fi
else
  install_all
fi

exit 1
