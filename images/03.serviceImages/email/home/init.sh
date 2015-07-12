#!/bin/sh

PID_FILE=/var/spool/postfix/pid/master.pid

export PID_FILE
. /home/trap.sh

mkdir -p /engines/var/run/flags/
sudo -n /sbin/syslogd -R syslog.engines.internal:5140

sudo -n postmap /etc/postfix/transport 
sudo -n postmap /etc/postfix/smarthost_passwd
sudo -n /usr/lib/postfix/master &

	
 #echo dbflavor=$dbflavor >/home/app/.dbenv
 #echo dbhost=$dbhost >>/home/auth/app/.dbenv
 #echo dbname=$dbname >>/home/app/.dbenv
 #echo dbpasswd=$dbpasswd >>/home/app/.dbenv
 #echo dbuser=$dbuser >>/home/app/.dbenv
 
echo "user = $dbuser" >/tmp/.db
echo "password = $dbpasswd" >>/tmp/.db
echo "hosts = $dbhost" >>/tmp/.db
echo "dbname = $dbname" >>/tmp/.db

	for tmpl in ` ls /home/mysql_tmpls`
		do
			cp /tmp/.db /etc/postfix/mysql/$tmpl
			cat /home/mysql_tmpls/$tmpl >> /etc/postfix/mysql/$tmpl
		done
rm /tmp/.db

cat /home/app/_config.inc.php \
 | sed "/DBHOST/s//$dbhost/"\
	| sed  "/DBNAME/s//$dbname/"\
	| sed  "/DBUSER/s//$dbuser/"\
	| sed   "/DBPASSWD/s//$dbpasswd/" > /home/app/config.inc.php

sudo -n  /usr/sbin/apache2ctl  -DFOREGROUND & 
touch /engines/var/run/flags/startup_complete  
wait 
rm -f /engines/var/run/flags/startup_complete
sudo /home/engines/scripts/_kill_syslog.sh

 
 

