#!/bin/sh

cat - | sudo -n /home/engines/scripts/backup/sudo/_restore.sh "$1" "$2"