
kill_syslog()
{
if test -f /home/engines/etc/SYSLOG
 then
   sudo -n  /home/engines/scripts/_kill_syslog.sh
fi
}

wait_for_pid_exit()
{
kill -0 $pid &>/dev/null

 if test $? -eq 0
  then
   count=30
   n=0
   kill -0 $pid &>/dev/null
    while test $? -eq 0
     do
      if test $count -lt $n
       then
        echo timeout shutting down $CONTAINER_NAME >> /home/engines/run/errors
        break
       fi
       n=`expr $n + 1` 
      sleep 1
      kill -0 $pid &>/dev/null
     done
 fi  
 }
 
default_signal_processor()
{
 if test -f $PID_FILE  
  then
   pids=`cat $PID_FILE`
     for pid in $pids
      do
        kill -0 $pid	
         if test $? -eq 0
          then
           if test -f /home/engines/scripts/signal/_signal.sh
  	        then
  	         echo sudo -n /home/engines/scripts/signal/_signal.sh $SIGNAL $pid
  	         sudo -n /home/engines/scripts/signal/_signal.sh $SIGNAL $pid
  	        else
  	   	     kill -$SIGNAL $pid	
  	   	     echo "-$SIGNAL $pid" >>  /home/engines/run/flags/signals
   	   	      if ! test $1 = HUP
               then 
                 wait_for_pid_exit   
               fi   	         
  	       fi    
         fi
     done	 			
 fi
 }
 
process_signal()
{
done=0

if ! test -z $KILL_SCRIPT
 then
  echo  termed $KILL_SCRIPT $SIGNAL >> /home/engines/run/flags/signals
   if test -f  $KILL_SCRIPT
    then
     echo  $KILL_SCRIPT $SIGNAL >> /home/engines/run/flags/signals
     $KILL_SCRIPT $SIGNAL
     done=1
   else  
     echo missing Script $KILL_SCRIPT >> /home/engines/run/flags/signals
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


