#!/bin/sh

if test -f  /home/engines/run/flags/sig_term
then
	rm -f /home/engines/run/flags/sig_term
fi 

if test -f  /home/engines/run/flags/termed
then
	rm -f /home/engines/run/flags/termed
fi 
if test -f  /home/engines/run/flags/sig_hup
then
	rm -f /home/engines/run/flags/sig_hup
fi 

if test -f  /home/engines/run/flags/huped
then
	rm -f /home/engines/run/flags/huped
fi 
if test -f  /home/engines/run/flags/sig_quit
then
	rm -f /home/engines/run/flags/sig_quit
fi 

if test -f  /home/engines/run/flags/quited
then
	rm -f /home/engines/run/flags/quited
fi 


trap_term()
	{
	SIGNAL=15
	export SIGNAL
	touch /home/engines/run/flags/sig_term
		if ! test -z $KILL_SCRIPT
		then
		   $KILL_SCRIPT $SIGNAL
		fi
	if test -f $PID_FILE  #if exists 
		then
		if test -f /home/engines/scripts/signal/_signal.sh
			then
				sudo -n/home/engines/scripts/signal/_signal.sh $SIGNAL $PID_FILE
			else
				pid=`cat $PID_FILE `		
				kill -$SIGNAL $pid	
				kill -0 $pid						 	
				if test $? -ne 0
        			then
                		echo no wait for  \"$pid\"
        		else
                		#echo wait \"$pid\"
                		wait $pid   >& /dev/null
				fi			
		fi
	  touch /home/engines/run/flags/termed	 			
	fi

	}
trap_hup()
{
SIGNAL=1
export SIGNAL
touch /home/engines/run/flags/sig_hup

 if ! test -z $KILL_SCRIPT
  then
	$KILL_SCRIPT $SIGNAL
 fi
 
 if test -f $PID_FILE
   then
	 if test -f /home/_signal.sh
	  then
		 sudo -n /home/_signal.sh $SIGNAL	$PID_FILE
	 else
		 kill -$SIGNAL `cat  $PID_FILE  `	
	 fi
	 touch /home/engines/run/flags/huped			
 fi		
}

trap_quit()
	{
	SIGNAL=15
	export SIGNAL
	touch /home/engines/run/flags/sig_quit
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
			 touch /home/engines/run/flags/quited
		fi
	
	}
	
	trap trap_term 15 
	trap trap_hup  1
	trap trap_quit 3
	
		if test -f $PID_FILE
	 		then
	 			echo "Warning stale $PID_FILE"
	 			rm -f $PID_FILE 1&>/dev/null
		fi
	 			
	

	