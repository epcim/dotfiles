#!/bin/sh

#rednotebook
sudo add-apt-repository ppa:rednotebook/stable
#virtualbox
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
echo "sudo sh -c \"echo deb http://download.virtualbox.org/virtualbox/debian $DISTRIB_CODENAME contrib > /etc/apt/sources.list.d/virtualbox.list\""
#airvideo
sudo add-apt-repository ppa:rubiojr/airvideo
#google (chrome, earth, etc.)
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo sh -c 'echo "deb http://dl.google.com/linux/earth/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo sh -c 'echo "deb http://dl.google.com/linux/talkplugin/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
#retext
sudo add-apt-repository ppa:mitya57/ppa
#profile-sync-daemon
sudo add-apt-repository ppa:graysky/utils
#everpad
sudo add-apt-repository ppa:nvbn-rm/ppa
#libreoffice (latest)
sudo add-apt-repository ppa:libreoffice/ppa
#smuxi irc client
sudo add-apt-repository ppa:meebey/ppa
#audio-recorder
apt-add-repository ppa:osmoma/audio-recorder

#install
sudo apt-get update
sudo apt-get install audio-recorder -y

## Install base
echo -e "\n"
echo 'TO INSTALL BASE AND PERSONALIZED LIST OF SOFTWARE RUN:'
echo 'cd ~/fabfile'
echo 'sudo apt-get install `cat desktop-base.swlist.ubuntu|xargs`'
echo 'sudo apt-get install `cat desktop-personal.swlist.ubuntu|xargs`'

## Manual
echo -e "\n"
echo "TO BE INSTALLED MANUALLY (DOWNLOAD): \
  yed
  ddrescue
  nomachine (client)
  virtualbox (latest)
  "

## IBM layer
echo -e "\n"
echo TO INSTALL IBM LAYER:
echo Add sources to /etc/apt/sources.list.d/ibm.list:
echo deb http://morbo.linux.ibm.com/ocdc ${DISTRIB_CODENAME}-safe IBM IBM-layer
echo deb-src http://morbo.linux.ibm.com/ocdc ${DISTRIB_CODENAME}-safe IBM IBM-layer
echo 'cd ~/fabfile'
echo 'sudo apt-get install `cat desktop-ibm.swlist.ubuntu|xargs`'
#TODO: ocdc layer, for IBM ubuntu installer


