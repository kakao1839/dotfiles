#chmod -x /bin/install.sh
#/bin/install.sh

set -u


DOT_DIR="$HOME/dotfiles"

has() {
    type "$1" > /dev/null 2>&1
}

if has "git"; then
    git clone https://github.com/kisqragi/dotfiles.git ${DOT_DIR}
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
    [ "$f" = "bin" ] && continue
    # シンボリックリンクを貼る
    ln -snfv ${PWD}/"$f" ~/
done
