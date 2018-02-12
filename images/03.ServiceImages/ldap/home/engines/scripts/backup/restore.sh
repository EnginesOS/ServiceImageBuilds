#!/bin/bash

touch /home/engnes/run/flags/backup
exit_code=0

cat -  | sudo -n /home/engines/scripts/backup/_restore.sh >& /tmp/restore.errs

if test $? -ne 0
 then 
   cat  /tmp/restore.errs  >&2
   exit_code=0
fi

rm  /home/engnes/run/flags/backup
exit $exit_code
