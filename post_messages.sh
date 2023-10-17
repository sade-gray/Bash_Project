#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Error, program requires 3 args"
  exit 1
fi

sender="$1"
receiver="$2"
message="$3"

if [ ! -d "$receiver" ]; then
  mkdir "$receiver"
  touch "$receiver/wall.txt"
  touch "$receiver/friends.txt"
fi

echo "$sender: $message" >> "$receiver/wall.txt"

echo "Your message has been posted to $receiver's wall"
exit 0