alias ls='ls --color=auto'

alias cp="cp -vi"
alias mv="timeout 8 mv -iv"
alias ping='ping -c 5'
alias dmesg='dmesg -HL --color'

alias psax="ps auxf | grep -i"
alias upgrade='yaourt -Syyua'
alias yt='youtube-dl -i --extract-audio --audio-format mp3 $url'

alias find-dups="find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate"

automat () {
    SCRIPTS=${HOME}/code/scripts
    upgrade
    sudo ${SCRIPTS}/solar-cln.sh
    ${SCRIPTS}/solar-inf.sh
    ${SCRIPTS}/solar-rm-sht.py --noconfirm
}
