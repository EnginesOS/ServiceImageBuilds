#!/bin/bash


echo master.pid kill -$1 `cat /var/spool/postfix/pid/master.pid`

 if  test -f /var/spool/postfix/pid/master.pid
  then
    kill -$1 `cat /var/spool/postfix/pid/master.pid`
 fi
 
