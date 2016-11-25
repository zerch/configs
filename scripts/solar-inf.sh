#!/bin/bash

USERS=$(who -q) UPTIME=$(uptime --pretty) DATE=$(date -R)
echo "Hello! Today is $DATE"
echo "Currently logged in: $( echo $USERS | sed "s/#.*//g" ) $UPTIME"
