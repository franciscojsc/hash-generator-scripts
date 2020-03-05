#!/bin/bash

# Author: Francisco Chaves <https://franciscochaves.com>
# Description: MD5 hash generator

TITLE="MD5 hash generator"

SELECTED_TYPE=$(zenity --title="$TITLE" --list --text "Choose the type to create the hash" \
    --radiolist \
    --column "Select" \
    --column "Type" \
    TRUE Text FALSE File);

case $SELECTED_TYPE in
    "Text")
        TEXT_PHRASE=$(zenity --title="$TITLE" --text "What is the text or phrase?" --width="150" --height="100" --entry)
        if test -n "$TEXT_PHRASE";
        then
        HASH_MD5=$(echo -n $TEXT_PHRASE | md5sum | cut -d ' ' -f1)
        zenity --info --title="$TITLE" --text="$HASH_MD5"
        else
            zenity --error --title="$TITLE" --text="Empty input" --width="150" --height="100"
        fi
        ;;
    "File")
        FILE=$(zenity --file-selection --title="Select a file")
        if test -e "$FILE";
        then
            HASH_MD5=$(md5sum "$FILE" | cut -d ' ' -f1)
            zenity --info --title="$TITLE" --text="$HASH_MD5"
        else
            zenity --error --title="$TITLE" --text="Not found file" --width="150" --height="100"
        fi
        ;;
        *)
        zenity --error --title="$TITLE" --text="Please select the type" --width="150" --height="100"
        ;;
esac