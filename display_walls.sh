#!/bin/bash

if [ "$#" -ne 1 ]; then
    exit 1
fi

wall="$1"

if [ ! -d "$wall" ]; then
#    echo "Error, this person's wall does not exist"
    return 2
fi

# more "$wall/wall.txt"

exit 0