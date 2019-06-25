#!/bin/sh

keys_dir=/home/backup/.ssh
 
 . /home/engines/functions/checks.sh

required_values="host private public"
check_required_values

echo "$private" > $keys_dir/$host

echo "$public" > $keys_dir/$host.pub
