#! /bin/bash

if [ -z "$1" ]; then
	exit 1
else
	sed -i 's/"$1"//' "locks.txt"
	exit 0
fi
