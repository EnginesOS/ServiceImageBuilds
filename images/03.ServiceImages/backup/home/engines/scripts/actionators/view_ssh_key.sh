#!/bin/sh

keys_dir=/home/backup/.ssh

 . /home/engines/functions/checks.sh

required_values="key_host"
check_required_values

cat $keys_dir/$key_host.pub
