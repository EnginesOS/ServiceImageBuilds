#!/bin/sh

PID_FILE=/tmp/sleep.pid
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/kill_sleep.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

service_first_run_check

/home/engines/scripts/startup/init_dbs.sh

sudo -nu opendkim /home/engines/scripts/engine/sudo/rebuild_dkim.key.sh
sudo -n -u opendkim /usr/sbin/opendkim  -l -W -v
echo $! > /home/engines/run/opendkim.pid 

sudo -n /home/engines/scripts/startup/sudo/_start_postfix.sh 
r=$?

if test $r -eq 0
 then
    startup_complete
	sleep 5	
 else
  echo "Failed with $r"
  exit $r	  
fi


while ! test -f /home/engines/run/flags/sig_term -o -f /home/engines/run/flags/sig_quit
 do 		
	 if ! test -f /var/spool/postfix/pid/master.pid
	  then
	   echo Exit as master pid file missing 
	   break
	 fi
    sleep 120 &
    echo $! >/tmp/sleep.pid
	wait 		
	exit_code=$?		
done	


/home/engines/scripts/signal/kill_sleep.sh

shutdown_complete

