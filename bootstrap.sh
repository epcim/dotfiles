#!/bin/bash -ex

git clone "https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick"
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

#mine
homeshick clone --batch epcim/dotfiles
homeshick clone --batch epcim/dotvim

#zsh & zsh powerline
homeshick clone --batch robbyrussell/oh-my-zsh
homeshick clone --batch https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme.git
#powerline awesome/qtile bindings
homeshick clone --batch https://github.com/Lokaltog/powerline
#powerline itself
sudo pip install --user git+git://github.com/Lokaltog/powerline

homeshick link

#powerline fonts
fc-cache -vf ~/.fonts

