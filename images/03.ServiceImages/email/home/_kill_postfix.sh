#!/bin/bash


 if ! test -f /var/spool/postfix/pid/master.pid
  then
    kill -$1 `cat /var/spool/postfix/pid/master.pid`
      kill -$1 `cat /var/apache2/apache.pid`
 fi
 
