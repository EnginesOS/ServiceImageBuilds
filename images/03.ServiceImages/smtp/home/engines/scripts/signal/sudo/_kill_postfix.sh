#!/bin/sh

if  test -f /var/spool/postfix/pid/master.pid
 then
   kill -$1 `cat /var/spool/postfix/pid/master.pid`
fi 
if  test -f /home/engines/run/opendkim.pid
 then
   kill -$1 `cat /home/engines/run/opendkim.pid `
fi 