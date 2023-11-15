#!/bin/bash

if [ "$#" -ne 3 ]; then
# echo "Error, program requires 3 args"
  exit 4
fi

sender="$1"
receiver="$2"
message="$3"

if [ ! -d "$receiver" ]; then
#  echo "Sorry, this friend could not be found"
  exit 1
fi

if [ ! -d "$sender" ]; then
#  echo "Sorry, this sender could not be found"
  exit 2
fi

if ! grep -q "$sender" "$receiver/friends.txt"; then
#  echo "Sorry, you are not friends, so this message could not be posted"
  exit 3
fi

./acquire.sh $receiver/wall.txt "$receiver"walllock.txt
echo "$sender: $message" >> "$receiver/wall.txt"
./release.sh "$receiver"walllock.txt

# echo "Your message has been posted to $receiver's wall"
exit 0