#!/bin/sh

keys_dir=/home/backup/.ssh

 . /home/engines/functions/checks.sh

required_values="host"
check_required_values

rm $keys_dir/$host $keys_dir/$host.pub