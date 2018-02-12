#!/bin/bash
exit_code=0
touch /home/engnes/run/flags/backup

sudo -n /home/engines/scripts/backup/_backup.sh &2> /tmp/backup.errs

if test $? -ne 0
 then 
   cat  /tmp/backup.errs  >&2
   exit_code=1
fi

rm /home/engnes/run/flags/backup
exit $exit_code