#!/bin/sh

 mkdir -p /engines/var/run/flags/
 
if ! test -f /engines/var/run/flags/first_run
  then
  	sudo /home/fix_permissions.sh
  	touch /engines/var/run/flags/first_run
  fi
  
KILL_SCRIPT=/home/kill_postfix.sh
export KILL_SCRIPT

PID_FILE=/var/spool/postfix/pid/master.pid

export PID_FILE
. /home/engines/functions/trap.sh

mkdir -p /engines/var/run/flags/
sudo -n /home/engines/scripts/_start_syslog.sh


sudo -n /usr/sbin/postmap /etc/postfix/transport 
sudo -n /usr/sbin/postmap /etc/postfix/smarthost_passwd
sudo -n /usr/lib/postfix/sbin/master  -w &

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
  

sleep 6
ap_pid=`cat /var/run/apache2/apache2.pid`
echo -n " $ap_pid" >> $PID_FILE
while test -f  /var/spool/postfix/pid/master.pid
 do
 	sleep 10&
 	wait
exit_code=$?
 done

rm -f /engines/var/run/flags/startup_complete
sudo -n /home/engines/scripts/_kill_syslog.sh

exit $exit_code
 

