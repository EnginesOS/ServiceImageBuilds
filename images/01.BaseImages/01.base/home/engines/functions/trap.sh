#!/bin/sh

clear_stale_flags()
{
 for flag in "sig_term termed sig_hup huped sig_quit quited"
 do
   if test -f /engines/var/run/flags/$flag
    then
	 rm -f /engines/var/run/flags/$flag
   fi 
 done
} 

custom_stop()
{
 if test -f /home/engines/scripts/custom_stop.sh
  then
   /home/engines/scripts/custom_stop.sh
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
	fi
		
 if test -f $PID_FILE  #if exists 
  then
    if test -f /home/_signal.sh
	 then
		sudo -n /home/_signal.sh $SIGNAL	`cat $PID_FILE`
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
}
	
trap_hup()
{
SIGNAL=1
export SIGNAL
touch /engines/var/run/flags/sig_hup
	
 if ! test -z $HUP_SCRIPT
	then
		  $HUP_SCRIPT $SIGNAL
 fi
if test -f $PID_FILE
	then
	  if test -f /home/_signal.sh
		then
		  sudo -n /home/_signal.sh $SIGNAL	$PID_FILE
		else
		   kill -$SIGNAL `cat  $PID_FILE  `	
	   fi
  touch /engines/var/run/flags/huped			
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
 fi
 if test -f $PID_FILE
	then
		if test -f /home/_signal.sh
		  then
		    sudo	/home/_signal.sh $SIGNAL	$PID_FILE	
		 else
		    kill -$SIGNAL `cat  $PID_FILE  `
			pid=`cat    $PID_FILE `				
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
}

clear_stale_flags	

trap trap_term 15 
trap trap_hup  1
trap trap_quit 3

if ! test -z $PID_FILE
then
	if ! test -d `dirname $PID_FILE`
	 then
	   mkdir -p `dirname $PID_FILE`
	fi   	
    if test -f $PID_FILE
     then
      #  echo "Warning stale $PID_FILE"
      kill -0 `cat $PID_FILE &> /dev/null`
        if test $? -ne 0
         then
           rm -f $PID_FILE &>/dev/null
        fi
    fi
fi
	 			
