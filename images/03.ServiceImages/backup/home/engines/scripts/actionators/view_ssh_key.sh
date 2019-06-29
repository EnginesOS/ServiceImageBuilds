#!/bin/sh

keys_dir=/home/backup/.ssh

 . /home/engines/functions/checks.sh

required_values="key_host"
check_required_values

if ! test -f $keys_dir/$key_host.pub
 then
   echo '{"status":"error","message":"nosuch key '$key_host'"}'
   exit 2
fi
   
cat $keys_dir/$key_host.pub
