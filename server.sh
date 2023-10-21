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
      bash ./create.sh "$id"
      ;;
    "add")
      echo "Please pass the first argument"
      read friend1
      echo "Please pass the second argument"
      read friend2
      bash ./add_friends.sh "$friend1" "$friend2"
      ;;
    "post")
      echo "Please pass the first argument"
      read sender
      echo "Please pass the second argument"
      read receiver
      echo "Please pass the third argument"
      read message
      bash ./post_messages.sh "$sender" "$receiver" "$message"
      ;;
    "display")
      echo "Please pass the wall"
      read wall
      bash ./display_walls.sh "$wall"
      ;;
    *)
      echo "Accepted commands: create/add/post/display/exit"
      ;;
  esac
done