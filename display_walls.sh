#!/bin/bash

if [ "$#" -ne 1 ]; then
    exit 1
fi

wall="$1"

./acquire.sh "display_wall" #only one person can acquire lock to friend files at a time
	check=$?
        if [ $check -eq 1 ]; then
         exit 3
        fi
        if [ $check -eq 2 ]; then
         exit 3
        fi

if [ ! -d "$wall" ]; then
#    echo "Error, this person's wall does not exist"
    ./release.sh "display_wall"
    exit 2
fi

# more "$wall/wall.txt"

exit 0
