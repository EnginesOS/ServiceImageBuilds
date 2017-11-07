#!/bin/sh

PID_FILE=/tmp/sleep.pid
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/kill_sleep.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

service_first_run_check


echo '{"default_domain":"'$DEFAULT_DOMAIN'"}' |/home/engines/scripts/configurators/set_default_domain.sh 

 
sudo -n /home/engines/scripts/configurators/rebuild_main.sh

if test -f /home/engines/scripts/configurators/saved/grey_listing_enabled
  then
  /home/engines/scripts/engine/start_grey.sh
fi


/home/engines/scripts/startup/init_dbs.sh
sudo -n /home/engines/scripts/startup/_start_postfix.sh &
startup_complete


while test -f /var/spool/postfix/pid/master.pid
 do
  sleep 3600 &
  echo $! > /tmp/sleep.pid
  wait
  echo sleep dead
   if test -f /tmp/sleep.pid
    then
  		rm /tmp/sleep.pid
  	fi
done 
	while ! test -f /home/engines/run/flags/sig_term -o -f /home/engines/run/flags/sig_quit
	do 
	    sleep 500 &
	    echo $! >/tmp/sleep.pid
		wait 		
		exit_code=$?		
		 if ! test -f /var/spool/postfix/pid/master.pid
		  then
		   break
		 fi
	done

shutdown_complete


