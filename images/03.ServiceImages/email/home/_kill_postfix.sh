#!/bin/bash


 if  test -f /var/spool/postfix/pid/master.pid
  then
    kill -$1 `cat /var/spool/postfix/pid/master.pid`
    echo kill -$1 `cat /var/spool/postfix/pid/master.pid`
    kill -$1 `cat /var/run/apache2/apache2.pid`
    echo kill -$1 `cat /var/run/apache2/apache2.pid`
    /home/engines/scripts/_kill_syslog.sh
 fi
 
