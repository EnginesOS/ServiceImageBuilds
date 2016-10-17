#!/bin/sh

PID_FILE=/var/spool/postfix/pid/master.pid

export PID_FILE
. /home/trap.sh

mkdir -p /engines/var/run/flags/
sudo -n /home/engines/scripts/_start_syslog.sh


sudo -n postmap /etc/postfix/transport 
sudo -n postmap /etc/postfix/smarthost_passwd
sudo -n /usr/lib/postfix/sbin/master &

/home/configurators/set_default_domain.sh '{"default_domain":"'$DEFAULT_DOMAIN'"}'

 echo dbflavor=$dbflavor >/home/email/.dbenv
 echo dbhost=$dbhost >>/home/email/.dbenv
 echo dbname=$dbname >>/home/email/.dbenv
 echo dbpasswd=$dbpasswd >>/home/email/.dbenv
 echo dbuser=$dbuser >>/home/email/.dbenv
 
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

/home/create_config.sh

sudo /home/configurators/rebuild_main.sh

if test -f /home/configurators/saved/grey_listing_enabled
  then
  /home/start_grey.sh
fi

sudo -n  /usr/sbin/apache2ctl  -DFOREGROUND & 
touch /engines/var/run/flags/startup_complete  
wait 
rm -f /engines/var/run/flags/startup_complete
sudo -n /home/engines/scripts/_kill_syslog.sh

 
 

