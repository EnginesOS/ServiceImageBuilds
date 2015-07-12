#!/bin/sh

PID_FILE=/var/run/dovecot/master.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags

cat /home/_dovecot-sql.conf.ext \
 | sed "/DBHOST/s//$dbhost/"\
	| sed  "/DBNAME/s//$dbname/"\
	| sed  "/DBUSER/s//$dbuser/"\
	| sed   "/DBPASSWD/s//$dbpasswd/" > /etc/dovecot/dovecot-sql.conf.ext
#sudo /usr/sbin/rsyslogd  -n -s syslog.engines.internal:5140 &

sudo syslogd  -R syslog.engines.internal:5140

sudo /usr/sbin/dovecot -F &
touch  /engines/var/run/flags/startup_complete
wait
sudo /home/engines/scripts/_kill_syslog.sh
rm /engines/var/run/flags/startup_complete