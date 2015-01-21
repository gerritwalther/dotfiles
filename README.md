# dotfiles

A place for my configuration files to have them available everywhere. For further information see http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/

I'm using Debian Testing, but most of the stuff should work on all linux systems.

## Installation

For now you have to link everything yourself.

### git

Move your user information (name and mail) to `.gituser` into your `$HOME`.

Link to the config file:

```
$ ln -s $PROJECT/dotfiles/gitconfig ~/.gitconfig
```
