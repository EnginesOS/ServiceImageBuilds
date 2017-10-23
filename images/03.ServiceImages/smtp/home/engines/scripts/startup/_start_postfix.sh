#!/bin/bash

rm /var/spool/postfix/pid/master.pid
/usr/lib/postfix/sbin/master -w
r=$?
if test $r -eq 0
 then
	sleep 5	
 else
  echo "Failed with $r"
  exit $r	  
fi
