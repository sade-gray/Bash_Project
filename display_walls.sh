#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Error, program requires 1 argument"
    exit 1
fi

wall="$1"

if [ ! -d "$wall" ]; then
    echo "Error, this person's wall does not exist"
    exit 1
fi

more "$wall/wall.txt"

exit 0
