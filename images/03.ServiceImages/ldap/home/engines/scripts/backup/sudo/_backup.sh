#!/bin/sh
#if test -z $1
# then
#    kill -TERM ` cat /home/engines/run/slapd.pid /home/engines/run/saslauthd.pid`
#   else
#     slapcat_args="-b $*" 
#  fi 
  pid=`cat /home/engines/run/slapd.pid`
 kill -TERM $pid
 kill -0 $pid
 while test $? eq 0
  do
    sleep 5
    kill -0 $pid
 done
    
slapcat $slapcat_args

