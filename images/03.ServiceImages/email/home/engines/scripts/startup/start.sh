#!/bin/sh

PID_FILE=/home/engines/run/sleep.pid
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/kill_sleep.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

service_first_run_check

if ! test -f /home/engines/scripts/configurators/saved/default_domain
 then
	echo '{}' > /home/engines/scripts/configurators/saved/default_domain
fi 

sudo -n /home/engines/scripts/configurators/rebuild_main.sh

if test -f /home/engines/scripts/configurators/saved/grey_listing_enabled
  then
  /home/engines/scripts/engine/start_grey.sh
fi


/home/engines/scripts/startup/init_dbs.sh
/home/engines/scripts/engine/init_ldap_config.sh

sudo -n /home/engines/scripts/startup/_start_postfix.sh &
startup_complete

# FIXME be mroe intelligent on waiting for process to start
sleep 5

while ! test -f /home/engines/run/flags/sig_term -o -f /home/engines/run/flags/sig_quit
 do 		
	 if ! test -f /var/spool/postfix/pid/master.pid
	  then
	   echo Exit as master pid file missing 
	   break
	 fi
    sleep 500 &
    echo $! >/home/engines/run/sleep.pid
	wait 		
	exit_code=$?
	rm /home/engines/run/sleep.pid
done

shutdown_complete


