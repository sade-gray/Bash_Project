#!/bin/bash

if [ "$#" -ne 2 ]; then
# echo "Usage: $0 <id> <friend>"
./release.sh "add_friends"
#added a 1 here. will change this soon
exit 1
fi

id="$1"
friend="$2"

if [ ! -d "$id" ];then
# echo "Error: User 'id' does not exist."
./release.sh "add_friends"
exit 1
fi

if [ ! -d "$friend" ];then
# echo "Error: User 'friend' does not exist."
./release.sh "add_friends"
exit 2
fi

if  grep -q "$friend" "$id/friends.txt"; then
# echo "Error: '$friend' is already a friend of '$id'."
./release.sh "add_friends"
exit 3
fi

./acquire.sh "add_friends" #only one person can acquire lock to friend files at a time
	check=$?
        if [ $check -eq 1 ]; then
         exit 4
        fi
        if [ $check -eq 2 ]; then
         exit 4
        fi

echo "$friend" >> "$id/friends.txt"
# echo "friend '$friend' added to the list of friends for user '$id'."
./release.sh "add_friends"
exit 0
