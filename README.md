# dotfiles

A place for my configuration files to have them available everywhere. For further information see http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/

I'm using Debian Testing, but most of the stuff should work on all linux systems.

## Requirements

install with `apt-get install`:
* i3
* dunst (might be installed along with i3)
* numlockx (used by the i3-configs)

install with `easy_install`:
* pip

install with `pip install`:
* py3status

## Installation

You can now use the installation script. See usage of the script.

### git

Move your user information (name and mail) to `.gituser` into your `$HOME`.

Link to the config file:

```
$ ln -s $PROJECT/dotfiles/gitconfig ~/.gitconfig
```
