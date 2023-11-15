#!/bin/bash
# echo "$#"

./acquire.sh "$user" "$user"lock

if [ "$#" -ne 1 ]; then
echo "Usage: $0 <id>"
./release.sh "$user"lock
exit 0
fi

id="$1"
# echo "$id"
if [ -d "$id" ]; then
# echo "Error: Directory '$id' already exists."
./release.sh "$user"lock
exit 1
fi
# echo "$id"
mkdir "$id"

touch "$id/wall.txt"
touch "$id/friends.txt"
./release.sh "$user"lock

# echo "Directory '$id' and files 'wall.txt' and 'friends.txt' created successfully."