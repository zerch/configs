export ZSH=/home/haos/.oh-my-zsh

ZSH_THEME=$(shuf -n 1 ${HOME}/.zsh_favlist)

export EDITOR=vim
export TERMINAL=urxvtc
export BROWSER=firefox

HISTSIZE=50000
SAVEHIST=50000

export PKG_CONFIG_PATH=/usr/lib/pkgconfig/
LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'

plugins=(colored-man git archlinux)

source $ZSH/oh-my-zsh.sh
if [[ -r $HOME/.bash_aliases ]] ; then
    source $HOME/.bash_aliases
fi

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
