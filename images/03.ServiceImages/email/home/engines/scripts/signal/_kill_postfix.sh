#!/bin/bash


 if  test -f /var/spool/postfix/pid/master.pid
  then
   kill -0 `cat /var/spool/postfix/pid/master.pid` 
    if test $? -eq 0
     then
    	kill $1 `cat /var/spool/postfix/pid/master.pid`
     fi
 fi
 
