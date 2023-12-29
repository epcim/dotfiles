#!/bin/bash

####
## Requirements

# brew
# curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh \
>|brew_install.sh
# less brew_install.sh
# bash brew_install.sh

####
## Bootstrap

# minimal sw
brew install git gitbatch zsh homeshick chezmoi starship fzf curl wget keepassxc bash openssh bat

# homeshick - will be replaced by chezmoi
which homeshick || {
	git clone "https://github.com/andsens/homeshick.git" $HOME/.homesick/repos/homeshick
	source "$HOME/.homesick/repos/homeshick/homeshick.sh"
}

test -e $HOME/.homesick/repos/dotshell ||
	homeshick clone --batch git://github.com/epcim/dotshell.git
test -d $HOME/.homesick/repos/dotfiles ||
	homeshick clone --batch git://github.com/epcim/dotfiles.git
test -d $HOME/.homesick/repos/dotvim ||
	homeshick clone --batch git://github.com/epcim/dotvim.git

homeshick link dotshell
homeshick link dotfiles
homeshick link dotvim

####
## Optionally

# hostname
# sudo scutil --set HostName dontpanic

# agree to xcode
# sudo xcrun cc

# osx setup
# from: https://gist.github.com/saetia/1623487
# Enable character repeat on keydown
defaults write -g ApplePressAndHoldEnabled -bool false
# Set a shorter Delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 12
# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0
# Set default Finder location to home folder (~/Workspace)
defaults write com.apple.finder NewWindowTarget -string "PfLo" &&
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Workspace" # PERSONAL FLAVOR !
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# Disable ext change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true
# Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Trackpad: map bottom right corner to right-click
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2 && \
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true && \
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1 && \
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
# Show the ~/Library folder
chflags nohidden ~/Library
# Disable Accented Character menu
#defaults write -g ApplePressAndHoldEnabled -bool false

# install z
curl https://raw.githubusercontent.com/rupa/z/master/z.sh -o ~/bin/z.sh
chmod u+x ~/bin/z.sh

# nerd fonts
# https://www.nerdfonts.com/font-downloads
brew tap homebrew/cask-fonts &&
	brew install --cask font-hack-nerd-font
brew install font-source-code-pro

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
	vlc unetbootin gimp firefox xz yq wget upx tmate tree sops restic readline pwgen tig sshuttle psutils protobuf openvpn nmap ncurses neovim moreutils

# go dev
brew install \
	postman \
	go \
	git-xargs

# py dev
brew install \
	pyenv pyenv-virtualenv pyenv-virtualenvwrapper

# tools
brew install \
	docker virtualbox vagrant htop findutils direnv jq jsonnet

# cloud & docker
brew install \
	terraform skopeo kustomize kubectl krew k9s eksctl azure-cli awscli aws-iam-authenticator google-cloud-sdk ansible ansible-lint salt helm

# cli & neovim dependencies
brew install \
	fd \
	ripgrep \
	lazygit

# k8s
kubectl krew install stern
kubectl krew install rbac-tool
kubectl krew install advise-policy
kubectl krew install rolesum
kubectl krew install np-viewer
kubectl krew install ksniff
kubectl krew install view-serviceaccount-kubeconfig

# ci & build
brew install \
	cmake make autoconf automake

# other
# https://gist.github.com/gaoqi7/6c295f696e66efd366c4e0f7632dd58a
brew install nnn mpv tmux xterm

# fish
brew install fisher fish
fisher install masa0x80/complete_ssh_host.fish
fisher install jethrokuan/fzf
fisher install jethrokuan/z
fisher install halostatue/fish-macos@v5.x
# fisher install IlanCosman/tide@v5 # prompt

# chezmoi.io
brew install chezmoi
# TODO: https://github.com/halostatue/dotfiles/tree/main/Setup

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

# SloopyFocus
# osascript -e 'id of app "Finder"'
defaults write com.apple.Terminal FocusFollowsMouse -bool true
defaults write net.kovidgoyal.kitty FocusFollowsMouse -bool true

# SystemPref/Privacy, enable terminal app FullDiskAccess
sudo systemsetup -setremotelogin on

# GNU first class experience
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
brew install coreutils
brew install gnu-tar
# alternatively
brew install iproute2mac
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
test -e ~/bin-osxoverride ||
	mkdir ~/bin-osxoverride
for i in $(ls /usr/local/bin/g*); do
	N=$(basename ${i/g//})
	ln -sf $i ~/bin-osxoverride/$N
done

# clipboard
# defaults write org.p0deje.Maccy ignoreEvents true
brew install --cask maccy

# nerd fonts (all)
brew search nerd-font | grep font | xargs -n1 brew install
