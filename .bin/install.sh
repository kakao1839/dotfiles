#!/bin/bash

echo "Please install NerdFont"
echo "https://www.nerdfonts.com"
### install packages ###
echo "================================="
echo "install packages"
echo "================================="
yes | sudo apt update
yes | sudo apt install build-essential curl file git
sleep 2
### install LinuxBrew ###
echo "================================="
echo "Start setting up LinuxBrew"
echo "================================="
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
# echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profilei

# echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> ~/.zshrc

echo -e "\n"

sleep 2
echo "================================="
echo "Setting zsh"
echo "================================="
yes | sudo apt install zsh
which zsh 
chsh -s /usr/bin/zsh $USER

brew install zplug
ln -s /home/linuxbrew/.linuxbrew/opt/zplug ~/.zplug

sleep 2
### Starship ###
echo "================================="
echo "Setting Starship"
echo "================================="

yes | curl -sS https://starship.rs/install.sh | sh

################################################
brew install lsd

sleep 2
################################################
echo END
exec $SHELL -l
