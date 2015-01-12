#!/bin/bash -ex

#TODO: Install git, zsh
#TODO: update to chef recipe


# ##############################################################

#TODO: MANUAL PREREQ to deply this homeshick (can be Chef recipe task)
test -d $HOME/.homesick/repos/homeshick || {
    git clone "https://github.com/andsens/homeshick.git" $HOME/.homesick/repos/homeshick
}
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# ##############################################################

#this
test -d $HOME/.homesick/repos/dotfiles || \
    homeshick clone --batch git://github.com/epcim/dotfiles.git
#OPTIONALLY
test -d $HOME/.homesick/repos/dotvim || \
    homeshick clone --batch git://github.com/epcim/dotvim.git
test -d $HOME/.homesick/repos/dotshell || \
    homeshick clone --batch git://github.com/epcim/dotshell.git

#powerline
sudo pip install --user git+git://github.com/Lokaltog/powerline
#powerline awesome/qtile bindings
test -d $HOME/.homesick/repos/powerline || \
    homeshick clone --batch https://github.com/Lokaltog/powerline


#setup +x for all *.sh.* files in the repo
find . -name "*.sh*" -type f -exec chmod u+x "{}" ";"
chmod u+x home/bin/*

homeshick link
#TODO: call all bootstrap.sh (in other repos)

which zsh && chsh -s $(which zsh)
ln -s $HOME/.homesick/repos/oh-my-zsh-powerline-theme/powerline.zsh-theme $HOME/.oh-my-zsh/themes/

#TODO: Remove following platform specific code:
#install zsh
INSTALLER=apt-get
which zsh || sudo $INSTALLER install zsh
#powerline fonts
fc-cache -vf ~/.fonts

