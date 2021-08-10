#!/bin/bash

####
# NOTICE:
# This file was not maintained for a longer period, PR is welcome


####
## Requirements

export PKG_TOOL=apt-get

####
## Initital setup

$PKG_TOOL install git zsh fish homeshick kitty starship fzf

# ensure homeshick
which homeshick || {
    git clone "https://github.com/andsens/homeshick.git" $HOME/.homesick/repos/homeshick
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
}

test -e $HOME/.homesick/repos/dotshell || {
    homeshick clone --batch git://github.com/epcim/dotshell.git
}
test -d $HOME/.homesick/repos/dotfiles || \
    homeshick clone --batch git://github.com/epcim/dotfiles.git


homeshick link dotshell
homeshick link dotfiles



####
## Optionally



####
## Advanced

sudo ufw allow ssh

# Ubutntu: set go in system default
#sudo update-alternatives --install "/usr/bin/go" "go" "/usr/local/go/bin/go" 0
#sudo update-alternatives --set go /usr/local/go/bin/go