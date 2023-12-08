#!/bin/bash

sudo apt update -y

#
# bash
#
rm ~/.bash_aliases
rm ~/.bashrc
ln -s ~/machine_setup/save_this_as_dot_bash_aliases ~/.bash_aliases
ln -s ~/machine_setup/save_this_as_dot_bashrc ~/.bashrc
source ~/.bashrc

#
# apt-installs - do them all here so we only have to enter sudo creds once :)
#
sudo apt install -y \
    arp-scan \
    curl \
#    fzf \  # this is done through my vim scripts
    gpustat \
    intel-gpu-tools \
    iperf3 \
    lm-sensors \
    openssh-server \
    python3-pip \
    rename \
    renameutils \
    silversearcher-ag \
    vim-gtk3 \
    zip unzip

#   
# networking tools
#
sudo add-apt-repository -y ppa:wireshark-dev/stable
sudo apt-get update -y
sudo apt-get install -y \
    ethtool \
    ifupdown \
    inetutils-traceroute \
    net-tools \
    tshark \
    vlan \
    wireshark
sudo dpkg-reconfigure wireshark-common
sudo adduser $USER wireshark
sudo usermod -a -G wireshark "$USER"

#
# git
#
git config --global user.email "peter.hutkins@glydways.com"
git config --global user.name "Peter Hutkins"
cp ~/machine_setup/.gitignore.txt ~/.gitignore

#
# tmux
#
#rm -rf ~/.tmux/
#rm -rf ~/.tmux.conf
#sudo apt install -y tmux
#mkdir -p ~/.tmux/plugins
#git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
#ln -s ~/machine_setup/tmux/.tmux.conf ~/.tmux.conf
#tmux source-file ~/.tmux.conf
#~/.tmux/plugins/tpm/scripts/install_plugins.sh
#rm -rf ~/.tmux/plugins/tmux/scripts
#ln -s ~/machine_setup/tmux/dracula/scripts ~/.tmux/plugins/tmux/

#
# ssh
#
sudo systemctl start ssh
sudo systemctl enable ssh

#
# bluetooth codecs
#
# sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp
# sudo apt install -y \
#     libldac \
#     pulseaudio-modules-bt \
#     libavcodec-extra58 \
#     libfdk-aac1 \
#     bluez \
#     pulseaudio \
#     pavucontrol
# pulseaudio -k
# systemctl --user enable pulseaudio
# systemctl --user start pulseaudio

#
# egpu switchers
#
# git clone https://github.com/karli-sjoberg/gswitch.git
# cd gswitch/
# sudo gswitch setup
#
# sudo snap install go --classic
# git clone git@github.com:hertg/egpu-switcher.git
# cd egpu-switcher
# make build -s
# sudo make install -s
# sudo egpu-switcher enable

#
# Clean up
#
source ~/.bashrc
sudo apt autoremove -y
