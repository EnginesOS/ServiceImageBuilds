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

