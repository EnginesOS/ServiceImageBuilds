#!/bin/bash
  echo kill postfix $1
  cat /var/spool/postfix/pid/master.pid

 if  test -f /var/spool/postfix/pid/master.pid
  then
   kill -0 `cat /var/spool/postfix/pid/master.pid` 2>/dev/null 1>/dev/null
    if test $? -eq 0
     then
    	kill -$1 `cat /var/spool/postfix/pid/master.pid`
     fi
 fi
 
