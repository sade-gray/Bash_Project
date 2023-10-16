#!/bin/bash

if [ "$#" -ne 1 ]; then
echo "Usage: $0 <id>"
exit 1
fi

id="$1"

if [ -d "$id" ]; then
echo "Error: Directory '$id' already exists."
exit 1
fi

mkdir "$id"

touch "$id/wall.txt"
touch "$id/friends.txt"

echo "Directory '$id' and files 'wall.txt' and 'friends.txt' created successfully."