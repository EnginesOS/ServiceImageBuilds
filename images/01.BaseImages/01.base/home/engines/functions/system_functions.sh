#!/bin/sh

startup_complete()
{
echo "Startup Complete"
touch /home/engines/run/flags/startup_complete
debug_catch_crash
}

shutdown_complete()
{
rm /home/engines/run/flags/startup_complete

  if test -f /home/engines/run/flags/wait_before_shutdown
   then
    sleep 210
  fi
  for P_FILE in $PID_FILE 
   do
    if test -f $P_FILE 
     then 
       rm $P_FILE
    fi
   done    
exit $exit_code
}

debug_catch_crash() 
{
 if test -f /home/engines/run/flags/debug
 then
  sleep 1
   if test -z $DEBUG_SLEEP
    then
     DEBUG_SLEEP=30
   fi
   if ! test -f $PID_FILE
    then 
      echo $CONTAINER_NAME crashed on start sleeping $DEBUG_SLEEP secs to allow debug
      sleep $DEBUG_SLEEP
   else
     kill -0 `cat $PID_FILE
      if test $? -ne 0
        then
         echo $CONTAINER_NAME crashed on start sleeping $DEBUG_SLEEP secs to allow debug
         sleep $DEBUG_SLEEP
      fi
   fi
fi
}
service_first_run_check()
{
if ! test -f /home/engines/run/flags/first_run.done
  then
    if test -f /home/engines/scripts/first_run/first_run.sh
     then
	   /home/engines/scripts/first_run/first_run.sh &> /home/engines/run/flags/first_run.log
	    if test $? -eq 0 
	     then
	       touch /home/engines/run/flags/first_run.done
	    fi
	 else
	   touch /home/engines/run/flags/first_run.done
	 fi   			
 fi
}

service_clear_restart_required()
{
if test -f /home/engines/run/flags/restart_required
 then
  rm -f /home/engines/run/flags/restart_required
fi
}

clear_stale_flags()
{
 for flag in sig_term termed sig_hup huped sig_quit quited
 do
   if test -f /home/engines/run/flags/$flag
    then
	 rm -f /home/engines/run/flags/$flag
   fi 
 done
} 

custom_stop()
{
 if test -f /home/engines/scripts/engine/custom_stop.sh
  then
   /home/engines/scripts/engine/custom_stop.sh $SIGNAL
 fi
}
