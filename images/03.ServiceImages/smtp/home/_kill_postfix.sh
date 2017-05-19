#!/bin/bash


 if  test -f /var/spool/postfix/pid/master.pid
  then
    kill -$1 `cat /var/spool/postfix/pid/master.pid`
    echo kill -$1 `cat /var/spool/postfix/pid/master.pid`
 /home/engines/scripts/_kill_syslog.sh
 fi
 
