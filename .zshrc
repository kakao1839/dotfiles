EDITOR=/usr/local/bin/nvim
cd ~
# alias
alias cdwin='cd /mnt/c'
alias v='nvim'
alias zshrc="nvim ~/.zshrc"
alias ls='lsd'
alias lsa='lsd -a'
alias ls='lsd --color=auto'
alias ls='lsd -G'
alias ll='lsd -alF'
alias ll='lsd -lh'
alias ll='lsd -l'
alias la='lsd -A'
alias la='lsd -a'
alias l='lsd -CF'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'


function custom_cd()
{
  \cd $@ && clear && lsa
}
alias cd='custom_cd'
# PATHの設定
export BREW_HOME="/home/linuxbrew/.linuxbrew/bin"
export PATH="$PATH:$BREW_HOME"
export XDG_CONFIG_HOME=$HOME/.config
export TERM=xterm-256color
export PATH=$HOME/go/bin:$PATH
export NVM_PYTHON_LOG_FILE=/tmp/logI
export NVIM_PYTHON_LOG_LEVEL=DEBUG
export DOCKER_CONTENT_TRUST=1

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

: "一般的な設定" && {
  autoload -U compinit && compinit -d ${COMPDUMPFILE} # 補完機能の強化
  zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' #補完で大文字を区別しない
  setopt correct # 入力しているコマンド名が間違っている場合にもしかして：を出す。
  setopt nobeep # ビープを鳴らさない
  setopt no_tify # バックグラウンドジョブが終了したらすぐに知らせる。
  # unsetopt auto_menu # タブによるファイルの順番切り替えをしない
  setopt auto_pushd # cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
  setopt auto_cd # ディレクトリ名を入力するだけでcdできるようにする
  setopt interactive_comments # コマンドラインでも # 以降をコメントと見なす
}


: "ヒストリ関連の設定" && {
  HISTSIZE=10000 # メモリに保存される履歴の件数
  SAVEHIST=10000 # 履歴ファイルに保存される履歴の件数
  HISTFILE=~/.zsh_history # 履歴ファイル  
  setopt hist_ignore_dups # 直前と同じコマンドをヒストリに追加しない
  setopt hist_ignore_all_dups # 重複するコマンドは古い法を削除する
  setopt share_history # 異なるウィンドウでコマンドヒストリを共有する
  setopt hist_no_store # historyコマンドは履歴に登録しない
  setopt hist_reduce_blanks # 余分な空白は詰めて記録
  setopt hist_verify # `!!`を実行したときにいきなり実行せずコマンドを見せる
}

: "キーバインディング" && {
  bindkey -e # emacs キーマップを選択
  : "Ctrl-Yで上のディレクトリに移動できる" && {
    function cd-up { zle push-line && LBUFFER='builtin cd ..' && zle accept-line }
    zle -N cd-up
    bindkey "^Y" cd-up
  }
  : "Ctrl-Dでシェルからログアウトしない" && {
    setopt ignoreeof
  }
  : "Ctrl-Wでパスの文字列などをスラッシュ単位でdeleteできる" && {
    autoload -U select-word-style
    select-word-style bash
  }
  : "Ctrl-[で直前コマンドの単語を挿入できる" && {
    autoload -Uz smart-insert-last-word
    zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*' # [a-zA-Z], /, \ のうち少なくとも1文字を含む長さ2以上の単語
    zle -N insert-last-word smart-insert-last-word
    bindkey '^[' insert-last-word
    # see http://qiita.com/mollifier/items/1a9126b2200bcbaf515f
  }
}

: "プラグイン" && {
  source ~/.zplug/init.zsh
  zplug "zsh-users/zsh-autosuggestions", defer:2  
  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug romkatv/powerlevel10k, as:theme, depth:1
  zplug "zsh-users/zsh-completions" # 多くのコマンドに対応する入力補完 … https://github.com/zsh-users/zsh-completions
  zplug "mafredri/zsh-async" # "sindresorhus/pure"が依存している
  zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme && { # 美しく最小限で高速なプロンプト … https://github.com/sindresorhus/pure
    export PURE_PROMPT_SYMBOL="❯❯❯"
  }
  zplug "zsh-users/zsh-syntax-highlighting", defer:2 # fishシェル風のシンタクスハイライト … https://github.com/zsh-users/zsh-syntax-highlighting
  zplug "supercrabtree/k" # git情報を含んだファイルリストを表示するコマンド … https://github.com/supercrabtree/k
  # zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf # あいまい検索ができるコマンド … https://github.com/junegunn/fzf
  # zplug "junegunn/fzf", as:command, use:bin/fzf-tmux # tmuxでfzfを使えるようにするプラグイン
  zplug "junegunn/fzf", use:shell/key-bindings.zsh # Ctrl-Rで履歴検索、Ctrl-Tでファイル名検索補完できる
  zplug "junegunn/fzf", use:shell/completion.zsh # cd **[TAB], vim **[TAB]などでファイル名を補完できる
  zplug "b4b4r07/enhancd", use:init.sh # cdコマンドをインタラクティブにするプラグイン … https://github.com/b4b4r07/enhancd
  zplug 'b4b4r07/gomi', as:command, from:gh-r # 消したファイルをゴミ箱から復元できるrmコマンド代替 … https://github.com/b4b4r07/gomi
  # zplug "momo-lab/zsh-abbrev-alias" # 略語展開(iab)を設定するためのプラグイン … http://qiita.com/momo-lab/items/b1b1afee313e42ba687b
  zplug "paulirish/git-open", as:plugin # GitHub, GitLab, BitBucketを開けるようにするコマンド … https://github.com/paulirish/git-open
  # # 未インストール項目をインストールする
  if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
          echo; zplug install
      fi
  fi
  zplug load
}

: "sshコマンド補完を~/.ssh/configから行う" && {
  function _ssh { compadd $(fgrep 'Host ' ~/.ssh/*/config | grep -v '*' |  awk '{print $2}' | sort) }
}

# : "cudaの環境変数" && {
#   export PATH="/usr/local/cuda/bin:$PATH"
#   export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
# }
# : "GolangのPATH" && {
#  export GOPATH=$HOME/work/go
#   export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
# }

# : "RubyのPATH" && {
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
# }

# gitignore生成コマンド
function gi() {
    curl -L -s https://www.gitignore.io/api/$@
}

# コマンドラインの出力をコピーするalias
alias pbcopy='xsel --clipboard --input'

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
# [[ -f /Users/suin/Dropbox/open/dotfiles/.config/yarn/global/node_modules/yarn-completions/node_modules/tabtab/.completions/yarn.zsh ]] && . /Users/suin/Dropbox/open/dotfiles/.config/yarn/global/node_modules/yarn-completions/node_modules/tabtab/.completions/yarn.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
