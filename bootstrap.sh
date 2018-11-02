#!/bin/bash -ex

if [[ -e /usr/bin/apt-get ]]; then
    sudo apt-get install -y git zsh fish curl python-pip
elif [[ -e /usr/bin/yum ]]; then
    sudo yum install -y git zsh fish curl python-pip
elif [[ -e /usr/local/bin/brew ]]; then
    brew install git zsh fish homeshick
fi


# ##############################################################

# Get homeshick
which homeshick || {
    git clone "https://github.com/andsens/homeshick.git" $HOME/.homesick/repos/homeshick
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
}

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
chmod u+x $HOME/bin/*

homeshick link

echo "call all bootstrap.sh (in other repos)"
find $HOME/.homesick/repos/ -name "bootstrap.sh" -type f -exec echo "{}" ";"


#powerline fonts on linux
which fc-cache && fc-cache -vf ~/.fonts

