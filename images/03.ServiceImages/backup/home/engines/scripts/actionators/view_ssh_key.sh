#!/bin/sh

keys_dir=/home/backup/.ssh

 . /home/engines/functions/checks.sh

required_values="host"
check_required_values


ssh-keygen -f $keys_dir/$key_host

cat $keys_dir/$key_host.pub