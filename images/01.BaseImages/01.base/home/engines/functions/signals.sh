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
   	   	     kill -0  $pid	
   	           if test $? -ne 0
                then
                 echo no wait for  \"$pid\" >> /home/engines/run/flags/signals
               else
                 echo wait \"$pid\"  >> /home/engines/run/flags/signals
                 wait $pid   
  	   	       fi			
  	       fi    
         fi
     done	 			
 fi
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
 
if test -f /home/engines/etc/SYSLOG
 then
   sudo -n  /home/engines/scripts/_kill_syslog.sh
fi
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

if test -f /home/engines/etc/SYSLOG
 then
   sudo -n  /home/engines/scripts/_kill_syslog.sh
fi
}
