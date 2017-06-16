#!/bin/sh

PID_FILE=/var/run/dovecot/master.pid
export PID_FILE
. /home/engines/functions/trap.sh


mkdir -p /engines/var/run/flags

cat /home/_dovecot-sql.conf.ext \
 | sed "/DBHOST/s//$dbhost/"\
	| sed  "/DBNAME/s//$dbname/"\
	| sed  "/DBUSER/s//$dbuser/"\
	| sed   "/DBPASSWD/s//$dbpasswd/" > /etc/dovecot/dovecot-sql.conf.ext


sudo -n /home/engines/scripts/_start_syslog.sh


sudo -n /usr/sbin/dovecot -F &
touch  /engines/var/run/flags/startup_complete
wait
exit_code=$?
sudo -n /home/engines/scripts/_kill_syslog.sh
rm /engines/var/run/flags/startup_complete
exit $exit_code