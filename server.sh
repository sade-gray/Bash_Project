#!/bin/bash

server_pipe="server.pipe"
if [ ! -p "$server_pipe" ]; then
    mkfifo "$server_pipe"
fi

while true; do
    # Read command from the named pipe
    read -r command < "$server_pipe"
    
    # Extract request type, ID, and arguments
    request=$(echo "$command" | awk '{print $1}')
    id=$(echo "$command" | awk '{print $2}')
    arg1=$(echo "$command" | awk '{print $3}')
    arg2=$(echo "$command" | awk '{print $4}')
    message=$(echo "$command" | awk '{for(i=5; i<=NF; i++) printf "%s", $i}')

    # Process requests using case statement
    echo "$command"
    case $id in
    "create")
        ./create.sh "$arg1"
        check=$?
        if [ "$check" -eq 1 ]; then
            echo "nok:" > "$arg2.pipe" &
        else
            echo "ok:" > "$arg2.pipe" &
        fi
        ;;
        "add")
   	if ! [ "$arg1" = '' ]; then 
                ./add_friend.sh "$arg2" "$arg1"
                check=$?
                if [ $check -eq 1 ]; then
                     echo "1" > "$arg2.pipe"
                elif [ $check -eq 2 ]; then
                    echo "2" > "$arg2.pipe"
                elif [ $check -eq 3 ]; then
                    echo "3" > "$arg2.pipe"
                elif [ $check -eq 4 ]; then
                    echo "4" > "$arg2.pipe"
                else
                    echo "ok:" > "$arg2.pipe"
                fi
            else
               exit 0
            fi
            ;;
        "post")
           if ! [ "$arg2" = '' ]; then 
                ./post_messages.sh "$arg2" "$arg1" "$message"
                check=$?
                
                if [ $check -eq 1 ]; then
                     echo "1" > "$arg2.pipe"
                elif [ $check -eq 2 ]; then
                    echo "2" > "$arg2.pipe"
                elif [ $check -eq 3 ]; then
                echo "3" > "$arg2.pipe"
                elif [ $check -eq 4 ]; then
                    echo "4" > "$arg2.pipe"
                elif [ $check -eq 5 ]; then
                    echo "4" > "$arg2.pipe"
                else
                    echo "ok:" > "$arg2.pipe"
                fi
            else
               exit 0
            fi
            ;;
        "display")
           	./display_walls.sh "$arg1"
           	check=$?
           	if [ $check -eq 2 ]; then
                     echo "2" > "$arg2.pipe"
                elif [ $check -eq 3 ]; then
                     echo "3" > "$arg2.pipe"
           	else
                    echo "ok:" > "$arg2.pipe"
                fi
           ;;
        "exit")
           echo "Exiting the program."
           break
           ;;
        *)
            echo "Accepted commands: create/add/post/display/exit" > "$arg2.pipe" &
            ;;
    esac
done
