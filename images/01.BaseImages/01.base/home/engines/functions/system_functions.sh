#!/bin/sh

startup_complete()
{
echo startup_complete > /home/engines/run/flags/state
echo "Startup Complete"
touch /home/engines/run/flags/startup_complete
touch /home/engines/run/flags/started
chgrp containers /home/engines/run/flags/started /home/engines/run/flags/startup_complete
chmod g+w /home/engines/run/flags/started /home/engines/run/flags/startup_complete
debug_catch_crash
}

shutdown_complete()
{
echo shutdown > /home/engines/run/flags/state
rm /home/engines/run/flags/startup_complete

if test -f /home/engines/run/flags/wait_before_shutdown
 then
  echo wait_before_shutdown > /home/engines/run/flags/state
  sleep 210
fi

for P_FILE in $PID_FILE 
 do
  if test -f $P_FILE 
   then 
     rm $P_FILE
  fi
 done    
 
touch /home/engines/run/flags/shutdown
echo "Shutdown Complete"
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
      echo Missing pid file $PID_FILE
      echo $CONTAINER_NAME crashed on start sleeping $DEBUG_SLEEP secs to allow debug
      echo debug > /home/engines/run/flags/state
      sleep $DEBUG_SLEEP
   else
      kill -0 `cat $PID_FILE`
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
     echo first_run > /home/engines/run/flags/state
       echo "Running First Run"     
	   /home/engines/scripts/first_run/first_run.sh &> /home/engines/run/flags/first_run.log
	   res=$?
	   cat /home/engines/run/flags/first_run.log
	     if test $res -eq 0 
	      then
	        echo "First Run Suceeded"     
	        touch /home/engines/run/flags/first_run.done
	     else
	        echo "First Run Failed with " +  $res     
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
for flag in sig_term termed sig_hup huped sig_quit quited startup_complete
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
     echo custom_stop > /home/engines/run/flags/state
  /home/engines/scripts/engine/custom_stop.sh $SIGNAL
  echo Custom Stop returned $?
fi
}

