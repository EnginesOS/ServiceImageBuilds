#!/bin/sh

if test -f /var/spool/postfix/pid/master.pid
 then
  pid=`cat /var/spool/postfix/pid/master.pid`
  sudo -n /home/engines/scripts/signal/_kill_postfix.sh $1
   if ! test $1 = HUP
    then
      wait_for_pid_exit
   fi
fi
