#!/bin/bash

if [ -z "$1" ]
then
    echo "No dropbox profile specified" >&2
    echo "Usage: $(basename "$0") profile command" >&2
    exit 1
fi

fold="$1"
shift
while [ "$fold" != "${fold/%\//}" ]
do 
    fold="${fold/%\//}"
done

if [ "$fold" = "." ]
then
    echo "Cannot use $fold as profile" >&2
    exit 1
fi

HOME="$HOME/.$fold"
if [ ! -d "$HOME" ]
then
    mkdir -p "$HOME"
    if [ $? -ne 0 ]
    then
	echo "An error occurred while creating profile directory" >&2
	exit 1
    fi
fi

dropbox "$@"
