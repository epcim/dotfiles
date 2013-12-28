#!/bin/bash -ex

#TODO: homeshick hook to set +x to .sh files, or workaround

#git clone "https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick"
git clone git://github.com/epcim/homeshick.git $HOME/.homesick/repos/homeshick
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


INSTALLER=apt-get
which zsh || sudo $INSTALLER install zsh
which zsh && chsh -s $(which zsh)

ln -s $HOME/.homesick/repos/oh-my-zsh-powerline-theme/powerline.zsh-theme $HOME/.oh-my-zsh/themes/

#powerline fonts
fc-cache -vf ~/.fonts

