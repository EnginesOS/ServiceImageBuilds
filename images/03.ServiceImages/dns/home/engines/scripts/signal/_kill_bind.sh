#!/bin/sh

pid=`cat /var/run/named/named.pid`
#if ! test $1 = HUP
# then 
#  rm /var/run/named/named.pid
#fi
# 
kill -$1 $pid



if ! test $1 = HUP
 then 
if test -f  /var/run/named/named.pid
  rm /var/run/named/named.pid
  fi
fi
 