#!/bin/bash
. /home/engines/functions/system_functions.sh

if test -f /var/spool/postfix/pid/master.pid
 then
	rm /var/spool/postfix/pid/master.pid
 fi

/usr/lib/postfix/sbin/master -w



