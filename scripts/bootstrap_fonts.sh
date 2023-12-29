#!/bin/bash -ex

# NO LONGER MAINTAINED

# zsh & powerline
homeshick clone --batch robbyrussell/oh-my-zsh
homeshick clone --batch https://github.com/seebi/dircolors-solarized
ln -s $HOME/.homesick/repos/dircolors-solarized/dircolors.256dark $HOME/.dircolors
ln -s $HOME/.homesick/repos/dircolors-solarized/dircolors.256dark $HOME/.dir_colors
#git clone --batch https://github.com/jeremyFreeAgent/oh-my-zsh-powerline-theme.git ~/.oh-my-zsh/custom/themes/powerline
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
# DEPRECATED
#sudo pip install --user powerline-status
#sudo pip install powerline-status
git clone https://github.com/powerline/fonts $HOME/.homesick/repos/powerline-fonts
$HOME/.homesick/repos/powerline-fonts/install.sh

#git clone https://github.com/ryanoasis/nerd-fonts $HOME/.homesick/repos/nerd-fonts

#FIXME, on osx only
brew tap caskroom/fonts
brew cask install font-hack-nerd-font


