#!/bin/bash

if [ -z "$1" ]; then
    exit 1
fi

if [ ! -p "locks.txt" ]; then
    touch "locks.txt"
fi

if grep -q "$1" "locks.txt"; then
    exit 2
fi

echo "$1" >> "locks.txt"
exit 0
