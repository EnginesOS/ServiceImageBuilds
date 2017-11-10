#!/bin/sh
#if test -f /var/run/named/named.pid
# then
#  pid=`cat /var/run/named/named.pid`
#
#  if test `kill -0 $pid &>/dev/null` -eq 0
#   then
#     kill -$1 $pid
#   fi
#   
#    if ! test $1 = HUP
#     then 
#      if test -f  /var/run/named/named.pid
#       then
#        rm /var/run/named/named.pid
#      fi
#    fi
#fi

PID_FILES=" /var/run/named/named.pid"
. /home/engines/functions/signals.sh

default_signal_processor
exit 0