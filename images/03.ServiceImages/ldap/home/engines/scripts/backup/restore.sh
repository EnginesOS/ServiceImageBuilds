#!/bin/bash

touch /home/engines/run/flags/backup
exit_code=0

cat - | sudo -n /home/engines/scripts/backup/_restore.sh >& /tmp/restore.errs

if test $? -ne 0
 then 
   cat  /tmp/restore.errs  >&2
   exit_code=1
fi
#KLUDGE FIX ME this is to give time to read buffers
#sleep 10
rm  /home/engines/run/flags/backup
exit $exit_code
