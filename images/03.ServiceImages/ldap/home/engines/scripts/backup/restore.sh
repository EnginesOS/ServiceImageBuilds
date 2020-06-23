#!/bin/sh

touch /home/engines/run/flags/backup
exit_code=0
 
echo $0 $1 $2 >/tmp/called
replace=$1
section=$2
if test "$1" == replace
 then
  cat - | sudo -n /home/engines/scripts/backup/sudo/_replace.sh $2
else
  cat - | sudo -n /home/engines/scripts/backup/sudo/_restore.sh $2
fi

if test $? -ne 0
 then 
   exit_code=1
fi
#KLUDGE FIX ME this is to give time to read buffers
#sleep 10
rm  /home/engines/run/flags/backup
exit $exit_code
