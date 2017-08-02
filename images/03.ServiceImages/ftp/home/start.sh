#!/bin/sh

sudo /home/engines/scripts/_start_syslog.sh


PID_FILE=/var/run/ftpd.pid
export PID_FILE
. /home/engines/functions/trap.sh
#
#/home/get_pubkey.sh access
#/home/get_pubkey.sh rm
#/home/get_pubkey.sh add
#
mkdir -p /engines/var/run/flags

#
##	while ! test -f  /home/ftpd/.ssh/access_rsa
##		do
##			sleep 10
##		done
#		
#	sleep 10
#	
#ssh -p 2222  -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /home/ftpd/.ssh/access_rsa auth@auth.engines.internal /home/auth/static/scripts/ftp/get_access.sh | /home/engines/bin/json_to_env >/tmp/.env
#
# . /tmp/.env
#
#if test -z $database_name
# then
# 	echo 'echo sleeping while debug'
#   sleep 500   
# fi
#
#cp /home/sql.conf.tmpl /tmp/sql.conf.tmpl
#echo "	SQLConnectInfo $database_name@$db_host $db_username $db_password " >> /tmp/sql.conf.tmpl
#echo  "</IfModule> " >> /tmp/sql.conf.tmpl
#cp /tmp/sql.conf.tmpl /etc/proftpd/sql.conf
#
sudo -n  /usr/sbin/proftpd -n &
touch  /engines/var/run/flags/startup_complete
wait 
exit_code=$?
sudo -n /home/engines/scripts/_kill_syslog.sh

rm /engines/var/run/flags/startup_complete
exit $exit_code