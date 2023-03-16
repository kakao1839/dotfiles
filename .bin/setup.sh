#!/bin/bash

echo "Please install NerdFont"
echo "https://www.nerdfonts.com"
### Create a symbolic link ###
echo "================================="
echo "Create a symbolic link"
echo "================================="
DOT_FILES=(.zshrc .config .bashrc .bash_profile )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

### install packages ###
echo "================================="
echo "install packages"
echo "================================="
yes | sudo apt update
yes | sudo apt install build-essential curl file git

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

echo "================================="
echo "Setting zsh"
echo "================================="
yes | sudo apt install zsh
which zsh 
chsh -s /usr/bin/zsh $USER

brew install zplug
ln -s /home/linuxbrew/.linuxbrew/opt/zplug ~/.zplug

### Starship ###
echo "================================="
echo "Setting Starship"
echo "================================="

curl -sS https://starship.rs/install.sh | sh

################################################
echo END
