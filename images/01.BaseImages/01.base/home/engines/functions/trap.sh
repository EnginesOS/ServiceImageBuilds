#!/bin/sh
. /home/engines/functions/system_functions.sh
. /home/engines/functions/signals.sh

clear_stale_flags	

trap trap_term 15 
trap trap_hup  1
trap trap_quit 3

if ! test -d /home/engines/run/flags/
 then 
  mkdir -p /home/engines/run/flags/
fi

echo trap > /home/engines/run/flags/state

if test -f /home/engines/etc/SYSLOG
 then
  sudo -n /home/engines/scripts/_start_syslog.sh
fi

if test -f /home/engines/etc/LOG_DIR
 then 
  LOG_DIR=`cat /home/engines/etc/LOG_DIR`
else
  LOG_DIR=/var/log
fi

for DIR in $LOG_DIR
do
 if ! test -d $DIR
  then
   mkdir -p $DIR
 fi
done

if test -z "$PID_FILES"
 then
  PID_FILES=$PID_FILE
fi

for PID_FILE in $PID_FILES
 do  
   if ! test -z $PID_FILE
   then
     if ! test -d `dirname $PID_FILE`
      then
   	  mkdir -p `dirname $PID_FILE`
     fi        
     if test -f $PID_FILE
      then
        echo "Warning stale $PID_FILE"
        kill -0 `cat $PID_FILE `
         if test $? -ne 0
          then
            rm -f $PID_FILE  
         fi
     fi
   fi
done

