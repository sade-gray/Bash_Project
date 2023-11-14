#!/bin/bash

if [ "$#" -ne 2 ]; then
# echo "Usage: $0 <id> <friend>"
exit 0
fi

id="$1"
friend="$2"

if [ ! -d "$id" ];then
# echo "Error: User 'id' does not exist."
exit 1
fi

if [ ! -d "$friend" ];then
# echo "Error: User 'friend' does not exist."
exit 2
fi

if  grep -q "$friend" "$id/friends.txt"; then
# echo "Error: '$friend' is already a friend of '$id'."
exit 3
fi

echo "$friend" >> "$id/friends.txt"
# echo "friend '$friend' added to the list of friends for user '$id'."