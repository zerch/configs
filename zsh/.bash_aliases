alias ls="ls --color=auto"

alias cp="cp -vi"
alias mv="timeout 8 mv -iv"
alias ping="ping -c 5"
alias dmesg="dmesg -HL --color"

alias psax="ps auxf | grep -i"
alias upgrade="sudo pacman -Syyu"
alias yt='youtube-dl -i --extract-audio --audio-format mp3 $url'

alias find-dups="find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate"
alias git-update-all='for dir in $(find . -name ".git"); do cd ${dir%/*}; pwd ; git pull ; cd -; done'

automat () {
    SCRIPTS=${HOME}/code/scripts
    upgrade
    sudo ${SCRIPTS}/solar-cln.sh
    ${SCRIPTS}/solar-inf.sh
    ${SCRIPTS}/solar-rm-sht.py --noconfirm
}
