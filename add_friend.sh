#!/bin/bash

./acquire.sh server.sh friendslocklock.txt #only one person can acquire lock to friend files at a time
	./acquire.sh "$id"/friends.txt "$id"friendslock.txt
	if ! [ $id == $friend ]; then
		./acquire.sh "$friend"/friends.txt "$friend"friendslock.txt
	fi
	./release.sh friendslocklock.txt

if [ "$#" -ne 2 ]; then
# echo "Usage: $0 <id> <friend>"
./release.sh friendslocklock.txt
exit 0
fi

id="$1"
friend="$2"

if [ ! -d "$id" ];then
# echo "Error: User 'id' does not exist."
./release.sh friendslocklock.txt
exit 1
fi

if [ ! -d "$friend" ];then
# echo "Error: User 'friend' does not exist."
./release.sh friendslocklock.txt
exit 2
fi

if  grep -q "$friend" "$id/friends.txt"; then
# echo "Error: '$friend' is already a friend of '$id'."
./release.sh friendslocklock.txt
exit 3
fi

echo "$friend" >> "$id/friends.txt"
# echo "friend '$friend' added to the list of friends for user '$id'."