#!/bin/sh
. /home/engines/functions/system_functions.sh
if test -f /home/engines/scripts/configurators/saved/enforce_dkim
 then
  sudo -n -u opendkim /usr/sbin/opendkim  -l -W -v
  echo $! > /home/engines/run/opendkim.pid
  chown postfix /home/engines/run/opendkim.pid
fi   

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






