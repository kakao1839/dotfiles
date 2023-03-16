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

echo "================================="
echo "Crete Symbolic link"
echo "================================="

set -u

DOT_DIR="$HOME/dotfiles"

has() {
    type "$1" > /dev/null 2>&1
}

if has "git"; then
    git clone https://github.com/kakao1839/dotfiles.git ${DOT_DIR}
elif has "curl" || has "wget"; then
    TARBALL="https://github.com/kakao1839/dotfiles/archive/master.tar.gz"
    if has "curl"; then
        curl -L ${TARBALL} -o master.tar.gz
    else
        wget ${TARBALL}
    fi
    tar -zxvf master.tar.gz
    rm -f master.tar.gz
    mv -f dotfiles-master "${DOT_DIR}"
else
    echo "curl or wget or git required"
    exit 1
fi

cd ${DOT_DIR}
# dotfilesディレクトリにある、ドットから始まり2文字以上の名前のファイルに対して
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    [ "$f" = ".bin" ] && continue
    # シンボリックリンクを貼る
    ln -snfv ${PWD}/"$f" ~/
done

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

