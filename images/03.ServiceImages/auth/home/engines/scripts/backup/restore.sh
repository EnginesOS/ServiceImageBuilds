#!/bin/sh

cat - | sudo -n /home/engines/scripts/backup/_restore.sh "$1" "$2"