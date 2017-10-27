#!/bin/bash

kill -0 `cat /var/run/krb5kdc.pid`
 if test $? -eq 0 
  then
	kill -$1 `cat /var/run/krb5kdc.pid`	
 fi
 
kill -0 `cat /var/run/krb5admin.pid ` 
 if test $? -eq 0 
  then
   kill -$1 `cat /var/run/krb5admin.pid `
 fi
 
if ! test $1 = HUP
 then 
 if test -f /var/run/krb5kdc.pid
  then
   pid=`cat /var/run/krb5kdc.pid` 
   count=30
   n=0
   kill -0 $pid`
   r=$?
    while test $r -eq 0
     do
      if test $count -lt $n
       then
        echo timeout shutting down
        break
       fi
       n=`expr $n + 1` 
      sleep 1
      kill -0 $pid`
     done
 fi    
fi
