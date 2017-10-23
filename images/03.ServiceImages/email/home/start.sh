#!/bin/sh
PID_FILE=/var/spool/postfix/pid/master.pid

export PID_FILE
. /home/engines/functions/trap.sh


if ! test -f /engines/var/run/flags/first_run
  then
  	/home/engines/scripts/first_run/first_run.sh
  	if test $? -eq 0
  	 then
  		touch /engines/var/run/flags/first_run
  	 fi
  fi
  
KILL_SCRIPT=/home/engines/scripts/signal/kill_postfix.sh
export KILL_SCRIPT

sudo -n /home/engines/scripts/_start_syslog.sh




echo '{"default_domain":"'$DEFAULT_DOMAIN'"}' |/home/engines/scripts/configurators/set_default_domain.sh 

 
sudo /home/engines/scripts/configurators/rebuild_main.sh

sudo -n /usr/lib/postfix/sbin/master  -w &


if test -f /home/engines/scripts/configurators/saved/grey_listing_enabled
  then
  /home/engines/scripts/startup/start_grey.sh
fi

touch /engines/var/run/flags/startup_complete
  
sleep 6

while test -f /var/spool/postfix/pid/master.pid
 do
 	sleep 10&
 	wait
    exit_code=$?
done

rm -f /engines/var/run/flags/startup_complete
sudo -n /home/engines/scripts/_kill_syslog.sh

exit $exit_code
 

