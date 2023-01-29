#!/bin/bash
if [ "$#" -lt 8 ]; then
  echo -e "\033[0;31mError: Invalid number of arguments provided. Usage: ./automation.sh --opt <targetdir> <vers> <type> <term> <comm> <name> <USER/SYSTEM-WIDE>\033[0m"
  exit 1
fi
if [ "$#" -lt 6 ]; then
  echo -e "\033[0;31mError: Not enough arguments provided.\033[0m"
  exit 1
fi

OPT=$1
TARGETDIR=$2
VERS=$3
TYPE=$4
TERM=$5
COMM=$6
NAME=$7
INST=$8

if [ "$OPT" != "--opt" ]; then
  echo -e "\033[0;31mError: Invalid option provided.\033[0m"
  exit 1
fi

function JSON_ENTRY() {
    "$(dirname "$0")/json-entry.sh" "$TARGETDIR" "$VERS" "$TYPE" "$TERM" "$COMM" "$NAME"
}

function DESK_ENTRY() {
    VARIABLEJS=$HOME/TMP/tmp.json

    if [ "$INST" == "USER" ]; then
        INSTDIR="$HOME/.local/share/applications/"
    elif [ "$INST" == "SYSTEM-WIDE" ]; then
        INSTDIR="/usr/local/share/applications/"
    else
        echo -e "\033[0;31mError: Invalid install type provided.\033[0m"
        exit 1
    fi

    "$(dirname "$0")/desk-entry.sh" "$VARIABLEJS" "$INSTDIR"
}

JSON_ENTRY
DESK_ENTRY "$INST"
