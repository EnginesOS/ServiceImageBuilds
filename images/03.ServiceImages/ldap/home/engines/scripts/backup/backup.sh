#!/bin/sh
exit_code=0

touch /home/engines/run/flags/backup

sudo -n /home/engines/scripts/backup/sudo/_backup.sh $* 

if test $? -ne 0
 then 
   exit_code=1
fi

rm /home/engines/run/flags/backup

exit $exit_code