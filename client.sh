#!/bin/bash


if [ -z "$1" ]; then
    echo "Error: Please provide a user ID."
    exit 1
fi

id="$1"
server_pipe="server.pipe"
client_pipe="$id.pipe"

if [ ! -p "$server_pipe" ]; then
    echo "Error: Server is not running."
    exit 1
fi

if [ ! -p "$client_pipe" ]; then
    mkfifo "$client_pipe"
fi

send_request() {
    local request="$1"
    echo "$request" > "$server_pipe"
}

while true; do
    # Read user request
    echo "Enter your request (create/add/post/display/exit):"
    read user_request

    case "$user_request" in
        "create")
            echo "Enter the user ID to create:"
            read user_id
            send_request "req create $user_id $id"
            read -r server_response < "$client_pipe"
            case "$server_response" in
                "ok:")
                    echo "SUCCESS: User created."
                    ;;
                "nok:")
                    echo "ERROR:  Directory '$user_id' already exists."
                    ;;
                *)
                    echo "$server_response"
                    ;;
            esac
            ;;
        "add")
            echo "Enter the friend's user ID to add:"
            read friend_id
            send_request "req add $friend_id $id"
            read -r server_response < "$client_pipe"
            case "$server_response" in
                "1")
           echo "Error: User 'id' does not exist."
                    ;;
                "2")
           echo "Error: User '$friend_id' does not exist."
                    ;;
                 "3")
           echo "Error: '$friend_id' is already a friend of yours."
                    ;;
                "ok:")
           echo "'$friend_id' added to the list of your friends."
                    ;;
                *)
                    echo "$server_response"
                    ;;
            esac
            ;;
        "post")
            echo "Enter the receiver's user ID:"
            read receiver_id
            echo "Enter the message:"
            read message
            send_request "req post $receiver_id $id $message"
            read -r server_response < "$client_pipe"
            case "$server_response" in
            	"1")
            echo "Sorry, this friend could not be found"
            		;;
            	"2")
            echo "Sorry, this sender could not be found"
            		;;
            	"3")
            echo "Sorry, you are not friends, so this message could not be posted"
            		;;
            	"ok:")
            	echo "Your message has been posted to $receiver_id's wall"
            	;;
           esac
           ;;
        "display")
            send_request "req display"
            echo "Enter the user ID you would like too view:"
            read receiver_id
            send_request "req display $receiver_id $id"
            read -r server_response < "$client_pipe"
            case "$server_response" in
            	"2")
            echo "Error, this person's wall does not exist"
            		;;
            	"ok:")
            more "$receiver_id/wall.txt"
            		;;
            esac
            ;;
        "exit")
            echo "Exiting the client."
            break
            ;;
        *)
            echo "Invalid request. Please enter create/add/post/display/exit."
            ;;
    esac
done


rm "$client_pipe"