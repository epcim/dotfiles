#!/bin/sh

#powerline
sudo pip install --user git+git://github.com/Lokaltog/powerline
#powerline fonts
fc-cache -vf ~/.fonts

#wget -O ~/.fonts/PowerlineSymbols.otf "https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf"
#wget -O ~/.config/fontconfig/conf.d/10-powerline-symbols.conf "https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf"
#wget -O ~/.fonts.conf.d//10-powerline-symbols.conf "https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf"
