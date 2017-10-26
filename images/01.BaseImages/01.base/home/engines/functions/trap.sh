#!/bin/sh

clear_stale_flags()
{
 for flag in sig_term termed sig_hup huped sig_quit quited
 do
   if test -f /engines/var/run/flags/$flag
    then
	 rm -f /engines/var/run/flags/$flag
   fi 
 done
} 

custom_stop()
{
 if test -f /home/engines/scripts/engine/custom_stop.sh
  then
   /home/engines/scripts/engine/custom_stop.sh
 fi
}


trap_term()
{
SIGNAL=15
export SIGNAL
touch /engines/var/run/flags/sig_term
custom_stop
	
	
if ! test -z $KILL_SCRIPT
 then
  $KILL_SCRIPT $SIGNAL
  touch /engines/var/run/flags/termed	
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
     touch /engines/var/run/flags/termed
   fi	 			
 fi
fi
}
	
trap_hup()
{
SIGNAL=1
export SIGNAL
touch /engines/var/run/flags/sig_hup
	
if ! test -z $HUP_SCRIPT
 then
   $HUP_SCRIPT $SIGNAL
   touch /engines/var/run/flags/huped	
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
    touch /engines/var/run/flags/huped
   fi			
 fi	
fi	
}

trap_quit()
{
SIGNAL=15
export SIGNAL
touch /engines/var/run/flags/sig_quit
custom_stop
	
if ! test -z $KILL_SCRIPT
 then
  $KILL_SCRIPT $SIGNAL				
  touch /engines/var/run/flags/quited
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
        touch /engines/var/run/flags/quited
      fi 
   fi	
fi
}

clear_stale_flags	

trap trap_term 15 
trap trap_hup  1
trap trap_quit 3

if ! test -d /engines/var/run/flags/
 then 
  mkdir -p /engines/var/run/flags/
fi

if ! test -z $PID_FILE
then
  if ! test -d `dirname $PID_FILE`
   then
	  mkdir -p `dirname $PID_FILE`
  fi
     	
  if test -f $PID_FILE
   then
     echo "Warning stale $PID_FILE"
     kill -0 `cat $PID_FILE &> /dev/null`
      if test $? -ne 0
       then
         rm -f $PID_FILE &>/dev/null
      fi
  fi
fi
	 			
