#!/bin/bash

#if test -f /var/run/krb5admin.pid
#  then
#   kill -0 `cat /var/run/krb5admin.pid` &>/dev/null
#    if test $? -eq 0 
#     then
#      kill -$1 `cat /var/run/krb5admin.pid `
#    fi
#fi 
#
#if test -f /var/run/krb5kdc.pid
#  then
#  kdcpid=`cat /var/run/krb5kdc.pid`
#   kill -0 $kdcpid &>/dev/null
#    if test $? -eq 0 
#     then
#	  kill -$1 $kdcpid
#    fi
# fi

. /home/engines/functions/signals.sh
PID_FILES="/var/run/krb5kdc.pid /var/run/krb5admin.pid"
default_signal_processor
ps -axl


#if ! test $1 = HUP
# then 
# pid=kdcpid
# wait_for_pid_exit   
#fi
