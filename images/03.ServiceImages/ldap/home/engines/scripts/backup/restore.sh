#!/bin/sh

touch /home/engines/run/flags/backup
exit_code=0

cat - | sudo -n /home/engines/scripts/backup/sudo/_restore.sh 

if test $? -ne 0
 then 
   exit_code=1
fi
#KLUDGE FIX ME this is to give time to read buffers
#sleep 10
rm  /home/engines/run/flags/backup
exit $exit_code
