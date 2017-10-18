#!/bin/sh

if ! test -f /engines/var/run/flags/first_run
  then
  	sudo -n /home/engines/scripts/smtp/_setup_dirs.sh
  	echo Fixed perms
  	touch /engines/var/run/flags/first_run
fi

PID_FILE=/var/spool/postfix/pid/master.pid

KILL_SCRIPT=/home/engines/scripts/smtp/kill_postfix.sh
export KILL_SCRIPT

export PID_FILE
. /home/engines/functions/trap.sh

sudo -n /home/engines/scripts/_start_syslog.sh

echo started syslog

if ! test -f /home/postfix/transport 
 then
	 echo "	*	smtp:" >/home/postfix/transport
fi 
if ! test -f /etc/postfix/mailname
 then
 sudo -n /home/engines/scripts/smtp/_set_mailname.sh "not.set"
fi
		
sudo -n /home/engines/scripts/smtp/_postmap.sh transport

sudo -n /usr/lib/postfix/sbin/master -w &

dummy=$!
echo started master $dummy
touch  /engines/var/run/flags/startup_complete

sleep 6
while test -f  /var/spool/postfix/pid/master.pid
 do
 	sleep 10 &
 	wait
    exit_code=$?
done


rm /engines/var/run/flags/startup_complete  
exit $exit_code

