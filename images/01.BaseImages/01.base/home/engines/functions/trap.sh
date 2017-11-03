#!/bin/sh

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


trap_term()
{
SIGNAL=15
export SIGNAL
touch /home/engines/run/flags/sig_term
custom_stop
	
	
if ! test -z $KILL_SCRIPT
 then
 echo  termed $KILL_SCRIPT $SIGNAL
  $KILL_SCRIPT $SIGNAL
  touch /home/engines/run/flags/termed	
else
 if test -f $PID_FILE  #if exists 
  then
   kill -0 `cat $PID_FILE `
    if test $? -eq 0
     then
      if test -f /home/engines/scripts/signal/_signal.sh
	   then
		sudo -n /home/engines/scripts/signal/_signal.sh $SIGNAL	`cat $PID_FILE`
	  else
		kill -$SIGNAL `cat    $PID_FILE `	
		pid=`cat    $PID_FILE `				
		echo $pid |grep ^[0-9]
 	     if test $? -ne 0
          then
           echo no wait for  \"$pid\"
          else
           echo wait \"$pid\"
           wait $pid   >& /dev/null
		 fi			
	 fi
     touch /home/engines/run/flags/termed
   fi	 			
 fi
fi
if test -f /home/engines/etc/SYSLOG
 then
   sudo -n  /home/engines/scripts/_kill_syslog.sh
fi
}
	
trap_hup()
{
SIGNAL=1
export SIGNAL
touch /home/engines/run/flags/sig_hup
	
if ! test -z $HUP_SCRIPT
 then
 echo  hup $HUP_SCRIPT $SIGNAL
   $HUP_SCRIPT $SIGNAL
   touch /home/engines/run/flags/huped	
else
 if test -f $PID_FILE
  then
   kill -0 `cat $PID_FILE `
    if test $? -eq 0
     then
	  if test -f /home/engines/scripts/signal/_signal.sh
	   then
		sudo -n /home/engines/scripts/signal/_signal.sh $SIGNAL	$PID_FILE
	  else
		kill -$SIGNAL `cat  $PID_FILE  `	
	  fi
    touch /home/engines/run/flags/huped
   fi			
 fi	
fi	
}

trap_quit()
{
SIGNAL=15
export SIGNAL
touch /home/engines/run/flags/sig_quit
custom_stop
	
if ! test -z $KILL_SCRIPT
 then
 echo  quited $KILL_SCRIPT $SIGNAL
  $KILL_SCRIPT $SIGNAL				
  touch /home/engines/run/flags/quited
else 
  if test -f $PID_FILE
   then
     kill -0 `cat $PID_FILE `
      if test $? -eq 0
       then
  	   if test -f /home/engines/scripts/signal/_signal.sh
  	    then
  	      sudo -n /home/engines/scripts/signal/_signal.sh $SIGNAL $PID_FILE	
  	   else
  	      kill -$SIGNAL `cat  $PID_FILE  `
  		  pid=`cat  $PID_FILE `				
  		  echo $pid |grep ^[0-9]
   	 	    if test $? -ne 0
          	  then
                 echo no wait for \"$pid\"
              else
                 echo wait \"$pid\"
                 wait $pid   
  		    fi
  	   fi				
        touch /home/engines/run/flags/quited
        
      fi 
   fi	
fi
if test -f /home/engines/etc/SYSLOG
 then
   sudo -n  /home/engines/scripts/_kill_syslog.sh
fi
}

clear_stale_flags	

trap trap_term 15 
trap trap_hup  1
trap trap_quit 3

if ! test -d /home/engines/run/flags/
 then 
  mkdir -p /home/engines/run/flags/
fi

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
  
if ! test -z $PID_FILE
then
  if ! test -d `dirname $PID_FILE`
   then
	  mkdir -p `dirname $PID_FILE`
  fi
     	
  if test -f $PID_FILE
   then
     echo "Warning stale $PID_FILE"
     kill -0 `cat $PID_FILE 2> /dev/null` &> /dev/null
      if test $? -ne 0
       then
         rm -f $PID_FILE &>/dev/null
      fi
  fi
fi


function startup_complete()
{
echo "Startup Complete"
touch /home/engines/run/flags/startup_complete
debug_catch_crash
}

function shutdown_complete()
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

function debug_catch_crash() 
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
