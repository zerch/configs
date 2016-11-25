#!/bin/bash

LOG_DIR=/var/log
ROOT_UID=0     # Only users with $UID 0 have root privileges.
LINES=50       # Default number of lines saved.
E_XCD=86       # Can't change directory?
E_NOTROOT=87   # Non-root exit error.
E_WRONGARGS=85 # Non-numerical argument (bad argument format).

# Run as root, of course.
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi

#if [ -n "$1" ]
## Test whether command-line argument is present (non-empty).
#then
  #lines=$1
#else
  #lines=$LINES # Default, if not specified on command-line.
#fi

CLEANALL=1
CLEAN_LINES=${1:-CLEANALL}
case "$1" in
""      ) lines=50;;
*[!0-9]*) echo "Usage: `basename $0` lines-to-cleanup";
 exit $E_WRONGARGS;;
CLEANALL) lines=$1;;
esac

#if [ `pwd` != "$LOG_DIR" ]  # or   if [ "$PWD" != "$LOG_DIR" ]
                            ## Not in /var/log?
#then
  #echo "Can't change to $LOG_DIR."
  #exit $E_XCD
#fi  # Doublecheck if in right directory before messing with log file.

# Far more efficient is:

cd $LOG_DIR || {
  echo "Cannot change to necessary directory." >&2
  exit $E_XCD;
}

tail -n $lines messages > mesg.temp # Save last section of message log file.
mv mesg.temp messages               # Rename it as system log file.

#  cat /dev/null > messages
#* No longer needed, as the above method is safer.

#cat /dev/null > wtmp  #  ': > wtmp' and '> wtmp'  have the same effect.
: > wtmp
echo "Log files cleaned up."

pacman -Rnsc $(pacman -Qtdq) --noconfirm
pacman -Sc --noconfirm
pacman -Scc --noconfirm
pacman-optimize

LOGFILE=${HOME}/solar-log.txt
[ ! -e $LOGFILE ] && touch $LOGFILE || ( rm $LOGFILE && touch $LOGFILE )

PACMAN_SYS=/etc/pacman.d
MIRRORLIST_PACNEW=$PACMAN_SYS/mirrorlist.pacnew

if [ -f $MIRRORLIST_PACNEW ]; then

    MIRRORLIST=$PACMAN_SYS/mirrorlist
    MIRRORLIST_BACKUP=$PACMAN_SYS/mirrorlist.backup
    TEMP_DIR=/tmp/solar

    mkdir -p -v $TEMP_DIR

    cd $TEMP_DIR || {
      echo "Cannot change to necessary directory." >&2
      exit $E_XCD;
    }

    cp -v $MIRRORLIST $MIRRORLIST_BACKUP
    cp -v $MIRRORLIST_PACNEW $TEMP_DIR
    sed -i "s/^.//g" $TEMP_DIR/mirrorlist.pacnew
    echo "Picking up first best 6 mirrors. This will take a while..."
    rankmirrors -v -n 6 $TEMP_DIR/mirrorlist.pacnew > $TEMP_DIR/mirrorlist
    cp -v $TEMP_DIR/mirrorlist $MIRRORLIST
    rm -rv $MIRRORLIST_PACNEW $TEMP_DIR
fi

SYSTEMCTL_STATUS=$(systemctl --failed)
echo "Failed systemd units:" >> $LOGFILE
[[ $SYSTEMCTL_STATUS == 0\ loaded\ units\ listed* ]] \
    && echo NONE >> $LOGFILE || echo $SYSTEMCTL_STATUS >> $LOGFILE
for i in {1}; do
    echo >> $LOGFILE
done

linkchk () {
    for element in $1/*; do
        if [[ ! $element == //proc* ]] \
          && [[ ! $element == //sys* ]] \
          && [[ ! $element == //var/run/* ]] \
          && [[ ! $element == //run/udev/* ]]
        then
            [ -h "$element" -a ! -e "$element" ] && echo \"$element\" | sed "s/\"//g" | sed "s/^.//" >> $LOGFILE
            [ -d "$element" ] && linkchk $element
        fi
    done
}

#echo "Broken symlinks:" >> $LOGFILE
#for directory in /; do
#    linkchk $directory
#done
#echo ; echo ; echo
#echo "Empty directories:" >> $LOGFILE
#find / -type d -empty -not -path /lost+found >> $LOGFILE

cat $LOGFILE

exit 0

