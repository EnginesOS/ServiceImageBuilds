#!/bin/sh


sudo syslogd -R syslog.engines.internal:514


PID_FILE=/var/run/ftpd.pid
export PID_FILE
. /home/trap.sh

mkdir -p /engines/var/run/flags
	
	while ! test -f  /home/ftpd/.ssh/access_rsa
		do
			sleep 10
		done
		
	sleep 5
	
service_hash=`ssh -p 2222  -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /home/ftpd/.ssh/access_rsa auth@auth.engines.internal /home/auth/static/scripts/ftp/get_access.sh`





 echo \'$service_hash\' | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if test -z $database_name
 then
 	echo 'echo sleeping while debug'
   sleep 500   
 fi

    cp /home/sql.conf.tmpl /tmp/sql.conf.tmpl
	echo "	SQLConnectInfo $database_name@$db_host $db_username $db_password " >> /tmp/sql.conf.tmpl
	echo  "</IfModule> " >> /tmp/sql.conf.tmpl
	cp /tmp/sql.conf.tmpl /etc/proftpd/sql.conf

sudo -n  /usr/sbin/proftpd -n &
 touch  /engines/var/run/flags/startup_complete
wait 
sudo -n /home/engines/scripts/_kill_syslog.sh

rm /engines/var/run/flags/startup_complete