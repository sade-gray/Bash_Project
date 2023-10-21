#!/bin/bash

while true; do
  echo "Please enter an operation or type 'exit' to quit"
  read operation

  if [ "$operation" = "exit" ]; then
    echo "Exiting the program."
    break
  fi

  case "$operation" in
    "create")
      echo "Please enter the id that you'd like to create"
      read id
      # Pass the 'id' variable as an argument to create.sh
      bash ./create.sh "$id"
      ;;
    "add")
      echo "Please pass the first argument"
      read friend1
      echo "Please pass the second argument"
      read friend2
      # Pass the 'friend1' and 'friend2' variables as arguments to add_friend.sh
      bash ./add_friends.sh "$friend1" "$friend2"
      ;;
    "post")
      echo "Please pass the first argument"
      read sender
      echo "Please pass the second argument"
      read receiver
      echo "Please pass the third argument"
      read message
      # Pass the 'sender,' 'receiver,' and 'message' variables as arguments to p
ost_message.sh
      bash ./post_messages.sh "$sender" "$receiver" "$message"
      ;;
    "display")
      echo "Please pass the wall"
      read wall
      # Pass the 'wall' variable as an argument to display_wall.sh
      bash ./display_walls.sh "$wall"
      ;;
    *)
      echo "Accepted commands: create/add/post/display/exit"
      ;;
  esac
done