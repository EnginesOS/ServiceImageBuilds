#!/bin/bash
. /home/engines/functions/system_functions.sh

rm /var/spool/postfix/pid/master.pid
/usr/lib/postfix/sbin/master -w
chgrp containers /var/spool/postfix/pid/master.pid
chmod g+r /var/spool/postfix/pid/master.pid
r=$?
if test $r -eq 0
 then
	sleep 5	
 else
  echo "Failed with $r"
  exit $r	  
fi






