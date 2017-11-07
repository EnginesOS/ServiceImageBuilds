#!/bin/bash

if test -f /var/run/krb5admin.pid
  then
   kill -0 `cat /var/run/krb5admin.pid` &>/dev/null
    if test $? -eq 0 
     then
      kill -$1 `cat /var/run/krb5admin.pid `
    fi
fi 

if test -f /var/run/krb5kdc.pid
  then
  kdcpid=`cat /var/run/krb5kdc.pid`
   kill -0 $kdcpid &>/dev/null
    if test $? -eq 0 
     then
	  kill -$1 $kdcpid
    fi
 fi



if ! test $1 = HUP
 then 
 if test -f /var/run/krb5kdc.pid
  then
   pid=`cat /var/run/krb5kdc.pid` 
   count=30
   n=0
   kill -0 $pid &>/dev/null
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
      kill -0 $pid &>/dev/null
      r=$?
     done
 fi    
fi
