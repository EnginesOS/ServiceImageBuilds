#!/bin/sh
PID_FILE=/var/spool/postfix/pid/master.pid

export PID_FILE
. /home/engines/functions/trap.sh
 
if ! test -f /engines/var/run/flags/first_run
  then
  	sudo /home/fix_permissions.sh
  	touch /engines/var/run/flags/first_run
  fi
  
KILL_SCRIPT=/home/kill_postfix.sh
export KILL_SCRIPT




sudo -n /home/engines/scripts/_start_syslog.sh


sudo -n /usr/sbin/postmap /etc/postfix/transport 
sudo -n /usr/sbin/postmap /etc/postfix/smarthost_passwd
sudo -n /usr/lib/postfix/sbin/master  -w &

echo '{"default_domain":"'$DEFAULT_DOMAIN'"}' |/home/configurators/set_default_domain.sh 


 
sudo /home/configurators/rebuild_main.sh

if test -f /home/configurators/saved/grey_listing_enabled
  then
  /home/start_grey.sh
fi

touch /engines/var/run/flags/startup_complete
  
sleep 6

while test -f  /var/spool/postfix/pid/master.pid
 do
 	sleep 10&
 	wait
    exit_code=$?
done

rm -f /engines/var/run/flags/startup_complete
sudo -n /home/engines/scripts/_kill_syslog.sh

exit $exit_code
 

