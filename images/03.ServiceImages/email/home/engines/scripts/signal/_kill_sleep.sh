#!/bin/sh
#  echo kill sleep $1
#
#/home/engines/scripts/signal/_kill_postfix.sh $1
# 
#if ! test 'HUP' = $1
# then
# pid=`cat /tmp/sleep.pid`
#   echo rm sleep
#  rm  /tmp/sleep.pid
#  kill -$1 $pid
#fi
#

PID_FILES="/var/spool/postfix/pid/master.pid /tmp/sleep.pid"
. /home/engines/functions/signals.sh

default_signal_processor
exit 0
