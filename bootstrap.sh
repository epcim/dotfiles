#!/bin/bash -ex

#TODO: Install git, zsh
#TODO: update to chef recipe


# ##############################################################

#TODO: MANUAL PREREQ to deply this homeshick (can be Chef recipe task)
#git clone "https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick"
git clone git://github.com/epcim/homeshick.git $HOME/.homesick/repos/homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# ##############################################################

#mine
homeshick clone --batch git://github.com/epcim/dotfiles.git
homeshick clone --batch git://github.com/epcim/dotvim.git

#zsh & zsh powerline
homeshick clone --batch robbyrussell/oh-my-zsh
homeshick clone --batch https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme.git
#powerline awesome/qtile bindings
homeshick clone --batch https://github.com/Lokaltog/powerline
#powerline itself
sudo pip install --user git+git://github.com/Lokaltog/powerline


#setup +x for all *.sh.* files in the repo
find . -name "*.sh*" -type f -exec chmod u+x "{}" ";"
chmod u+x home/bin/*

homeshick link

which zsh && chsh -s $(which zsh)
ln -s $HOME/.homesick/repos/oh-my-zsh-powerline-theme/powerline.zsh-theme $HOME/.oh-my-zsh/themes/

#TODO: Remove following platform specific code:
#install zsh
INSTALLER=apt-get
which zsh || sudo $INSTALLER install zsh
#powerline fonts
fc-cache -vf ~/.fonts

