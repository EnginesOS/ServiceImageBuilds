#!/bin/sh

if ! test -f /engines/var/run/flags/first_run
  then
  	sudo /home/fix_permissions.sh
  	echo Fixed perms
  	touch /engines/var/run/flags/first_run
  fi

PID_FILE=/var/spool/postfix/pid/master.pid

KILL_SCRIPT=/home/kill_postfix.sh
export KILL_SCRIPT

export PID_FILE
. /home/engines/functions/trap.sh

mkdir -p /engines/var/run/flags/

sudo -n /home/engines/scripts/_start_syslog.sh

echo started syslog

if ! test -f /etc/postfix/transport 
	then
	 echo "	*	smtp:" >/etc/postfix/transport
	fi 
if ! test -f /etc/postfix/mailname
	then
		echo "not.set" > /etc/postfix/mailname
	fi
		
sudo -n /usr/sbin/postmap /etc/postfix/transport

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
sudo -n /home/engines/scripts/_kill_syslog.sh
exit $exit_code

