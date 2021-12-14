#!/bin/bash

####
## Requirements

# brew
# curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh \
  >| brew_install.sh
# less brew_install.sh
# bash brew_install.sh


####
## Bootstrap

# minimal sw
brew install git gitbatch zsh homeshick starship fzf curl wget keepassxc bash openssh bat

# homeshick
which homeshick || {
    git clone "https://github.com/andsens/homeshick.git" $HOME/.homesick/repos/homeshick
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
}

test -e $HOME/.homesick/repos/dotshell || \
    homeshick clone --batch git://github.com/epcim/dotshell.git
test -d $HOME/.homesick/repos/dotfiles || \
    homeshick clone --batch git://github.com/epcim/dotfiles.git
test -d $HOME/.homesick/repos/dotvim || \
    homeshick clone --batch git://github.com/epcim/dotvim.git

    
homeshick link dotshell
homeshick link dotfiles
homeshick link dotvim


####
## Optionally


# install z
curl https://raw.githubusercontent.com/rupa/z/master/z.sh -o ~/bin/z.sh
chmod u+x ~/bin/z.sh

# nerd fonts
# https://www.nerdfonts.com/font-downloads
brew tap homebrew/cask-fonts &&
brew install --cask font-hack-nerd-font


# # powerline symbols (deprecated, replaced by nerd fonts)
#
# cd Downloads
# wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
# wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
# FO_DIR=~/.local/share/fonts/
# mkdir -p $FO_DIR || true
# test -e  $FO_DIR/PowerlineSymbols.otf ||\
#   mv PowerlineSymbols.otf $FO_DIR
# fc-cache -vf  || true
# FC_DIR=~/.config/fontconfig/conf.d/
# mkdir -p $FC_DIR || true
# test -e  $FC_DIR/10-powerline-symbols.conf ||\
#   mv 10-powerline-symbols.conf $FC_DIR
# fc-cache -vf  || true
# cd ~


# powerline (deprecated, replaced by starshipt prompt)
#
# # powerline 10k
# see https://github.com/romkatv/powerlevel10k
#
# # powerline 9k
# brew tap sambadevi/powerlevel9k
# brew install powerlevel9k
# # echo "source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc


####
# software
# other
brew install \
  vlc\
  unetbootin\
  gimp\
  firefox\
  xz\
  yq\
  wget\
  upx\
  tmate\
  tree\
  sops\
  restic\
  readline\
  pwgen\
  tig\
  sshuttle\
  psutils\
  protobuf\
  openvpn\
  nmap\
  ncurses\
  neovim\
  moreutils

# go dev
brew install \
  postman \
  go


# py dev
brew install \
  pyenv\
  pyenv-virtualenv\
  pyenv-virtualenvwrapper

# tools
brew install \
  docker\
  virtualbox\
  vagrant\
  htop\
  findutils\
  direnv\
  jq\
  jsonnet

# cloud & docker
brew install \
  terraform\
  skopeo\
  kustomize\
  kubectl\
  k9s\
  eksctl\
  azure-cli\
  awscli\
  aws-iam-authenticator\
  google-cloud-sdk\
  ansible\
  ansible-lint\
  salt\
  helm


# ci & build
brew install \
  cmake\
  make\
  autoconf\
  automake


####
## Advanced

# pyenv
mkdir -p ~/.pyenv || true

# vscode workaround
ln -sf ~/.config/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json

# keyboard, vim mode for VScode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false 
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# SloopyFocus (wont work for me)
# osascript -e 'id of app "Finder"'
defaults write com.apple.Finder FocusFollowsMouse -bool true
defaults write com.apple.Terminal FocusFollowsMouse -bool true
defaults write net.kovidgoyal.kitty FocusFollowsMouse -bool true
defaults write com.microsoft.VSCode FocusFollowsMouse -bool true
defaults write com.apple.x11 wm_ffm -bool true

# Window arangement
#https://github.com/ianyh/Amethyst
# brew install --cask amethyst
#https://github.com/sbmpost/AutoRaise
# brew tap dimentium/autoraise
# brew install autoraise
# brew services start autoraise

# SystemPref/Privacy, enable terminal app FullDiskAccess
sudo systemsetup -setremotelogin on


# GNU first class experience
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
brew install coreutils
brew install gnu-tar
# alternatively
brew install binutils
brew install diffutils
brew install ed
brew install findutils
brew install gawk
brew install gnu-indent
brew install gnu-sed
brew install gnu-which
brew install gnutls
brew install grep
brew install gzip
brew install screen
brew install watch
brew install util-linux
test -e ~/bin-osxoverride ||\
  mkdir ~/bin-osxoverride
for i in $(ls /usr/local/bin/g*) ;do N=$(basename ${i/g//}); ln -sf $i ~/bin-osxoverride/$N; done


# nerd fonts (all)
brew search nerd-font |grep font | xargs -n1 brew install


