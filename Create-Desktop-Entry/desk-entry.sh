#!/bin/bash

# Base variables
VARIABLEJS=$1
DESKENTDIR=$2

# Grab objects & to variables
function JS2VAR() {
    echo $(cat $VARIABLEJS) | jq -r $1
}

VERS=$(JS2VAR '.vers')
TYPE=$(JS2VAR '.type')
TERM=$(JS2VAR '.term')
EXEC=$(JS2VAR '.exec')
NAME=$(JS2VAR '.name')
ICON=$(JS2VAR '.icon')
COMM=$(JS2VAR '.comm')

# Create .desktop file
NDESK=$DESKENTDIR/$NAME.desktop
echo '[DESKTOP ENTRY]'>$NDESK

# Write to .desktop file
echo "Encoding=UTF-8">>$NDESK
echo "Type=$TYPE">>$NDESK
echo "Version=$VERS">>$NDESK
echo "Name=$NAME">>$NDESK
echo "Comment=$COMM">>$NDESK
echo "Terminal=$TERM">>$NDESK
echo "Exec=$EXEC">>$NDESK
echo "Icon=$ICON">>$NDESK

