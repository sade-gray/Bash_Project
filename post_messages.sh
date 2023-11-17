#!/bin/bash

if [ "$#" -ne 3 ]; then
# echo "Error, program requires 3 args"
  exit 5
fi

sender="$1"
receiver="$2"
message="$3"

./acquire.sh "post_message" #only one person can acquire lock to friend files at a time
	check=$?
        if [ $check -eq 1 ]; then
         exit 4
        fi
        if [ $check -eq 2 ]; then
         exit 4
        fi

if [ ! -d "$receiver" ]; then
#  echo "Sorry, this friend could not be found"
./release.sh "post_message"
  exit 1
fi

if [ ! -d "$sender" ]; then
#  echo "Sorry, this sender could not be found"
./release.sh "post_message"
  exit 2
fi

if ! grep -q "$sender" "$receiver/friends.txt"; then
#  echo "Sorry, you are not friends, so this message could not be posted"
./release.sh "post_message"
  exit 3
fi

echo "$sender: $message" >> "$receiver/wall.txt"
./release.sh "post_message"

# echo "Your message has been posted to $receiver's wall"
exit 0
