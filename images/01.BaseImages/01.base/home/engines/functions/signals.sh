
kill_syslog()
{
if test -f /home/engines/etc/SYSLOG
 then
   sudo -n /home/engines/scripts/_kill_syslog.sh
fi
}

wait_for_pid_exit()
{

kill -0 $pid  
r=$?
if test $r -eq 0
 then
  count=30
  n=0
  kill -0 $pid 
  r=$?
   while test $r -eq 0
    do
     if test $count -lt $n
      then
       echo timeout shutting down $CONTAINER_NAME >> /home/engines/run/errors
       break
      fi
     n=`expr $n + 1` 
     sleep 1
     kill -0 $pid  
     r=$?
   done
fi  
}
 
rm_pid_file()
{
if test -f $PID_FILE
 then
  rm $PID_FILE
fi			
}

default_signal_processor()
{
if test -z "$PID_FILES"
 then
  PID_FILES=$PID_FILE
fi
   
for PID_FILE in $PID_FILES
 do
  if test -f $PID_FILE  
   then
    pids=`cat $PID_FILE`
     for pid in $pids
      do
       kill -0 $pid	
        if test $? -eq 0
         then
  	       kill -$SIGNAL $pid	
  	       echo "-$SIGNAL $pid" >> /home/engines/run/flags/signals  
           if ! test $SIGNAL = HUP
            then 
              echo wait $pid >> /home/engines/run/flags/signals
              wait_for_pid_exit   
              rm_pid_file
           fi
        else
           rm_pid_file    
        fi
      done	 
  fi
done 
}
 
process_signal()
{
done=0

if test $SIGNAL = HUP
 then
  if ! test -z $HUP_SCRIPT
    then
     echo  termed $HUP_SCRIPT $SIGNAL >> /home/engines/run/flags/signals
      if test -f $HUP_SCRIPT
       then
        echo  $HUP_SCRIPT $SIGNAL >> /home/engines/run/flags/signals
        $HUP_SCRIPT 
        done=1
      else  
        echo Missing script $HUP_SCRIPT >> /home/engines/run/flags/signals
      fi
  fi     	   
else
  if ! test -z $KILL_SCRIPT
   then
    echo  termed $KILL_SCRIPT $SIGNAL >> /home/engines/run/flags/signals
     if test -f $KILL_SCRIPT
      then
        echo  $KILL_SCRIPT $SIGNAL >> /home/engines/run/flags/signals
        $KILL_SCRIPT $SIGNAL
         if test $? -eq 0
          then
            done=1
         else
           echo $KILL_SCRIPT error running default >> /home/engines/run/flags/signals
         fi
     else  
        echo Missing script $KILL_SCRIPT >> /home/engines/run/flags/signals
     fi
  fi     	
fi

if test $done -eq 0
 then
   default_signal_processor
fi
}

trap_term()
{
SIGNAL=TERM
export SIGNAL
touch /home/engines/run/flags/sig_term
custom_stop

process_signal

touch /home/engines/run/flags/termed
 
kill_syslog
}
	
trap_hup()
{
SIGNAL=HUP
export SIGNAL
touch /home/engines/run/flags/sig_hup

process_signal	

touch /home/engines/run/flags/huped

}

trap_quit()
{
SIGNAL=KILL
export SIGNAL
touch /home/engines/run/flags/sig_quit
custom_stop
	
process_signal	

touch /home/engines/run/flags/quited        

kill_syslog
}


