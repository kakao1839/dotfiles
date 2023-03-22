# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Set up the prompt

# autoload -Uz promptinit
# promptinit
# prompt adam1

export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

cd ~
# alias
alias cdwin='cd /mnt/c'
alias v='nvim'
alias vi='nvim'
alias zshrc="nvim ~/.zshrc"
alias ls='lsd'
alias lsa='lsd -a'
alias ls='lsd --color=auto'
alias ll='lsd -alF'
alias ll='lsd -lh'
alias ll='lsd -l'
alias la='lsd -A'
alias la='lsd -a'
alias l='lsd -CF'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias cat='bat'


##########################################
zstyle ':completion:*' use-cache true # apt-getとかdpkgコマンドをキャッシュを使って速くする

zstyle ':completion:*' list-separator '-->'
##########################################
# zplug
source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# 非同期処理できるようになる
zplug "mafredri/zsh-async"
# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"
# コマンド入力途中で上下キー押したときの過去履歴がいい感じに出るようになる
zplug "zsh-users/zsh-history-substring-search"
# 過去に入力したコマンドの履歴が灰色のサジェストで出る
zplug "zsh-users/zsh-autosuggestions"
# 補完強化
zplug "zsh-users/zsh-completions"
# 256色表示にする
zplug "chrissicool/zsh-256color"
# コマンドライン上の文字リテラルの絵文字を emoji 化する
zplug "mrowa44/emojify", as:command

zplug "agkozak/zsh-z"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
# コマンドの履歴機能
# 履歴ファイルの保存先
HISTFILE=$HOME/.zsh_history
# メモリに保存される履歴の件数
HISTSIZE=10000
# HISTFILE で指定したファイルに保存される履歴の件数
SAVEHIST=10000
# Then, source plugins and add commands to $PATH
zplug load

############################################

#cdを打ったら自動的にlsを打ってくれる関数
function cd(){
    builtin cd $@ && ls;
}

# Starship
eval "$(starship init zsh)"

# Linuxbrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

#gh
eval "$(gh completion -s zsh)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
