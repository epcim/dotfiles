#!/bin/bash -ex

#After boostrap_software.sh

#TODO: rewrite to chef recipe
#TODO: bootstrap SYSTEM - fabfile
# chef/solo or fabfile to:
# fabfile users/sudoers
# fabfile config os/fw/ports/broadcasts
# SSH keys
# vi /etc/psd.conf (username)


# Enable SSHD
sudo ufw allow ssh

#
