#!/bin/sh



PID_FILE=/var/run/krb5kdc.pid 
export PID_FILE
. /home/engines/functions/trap.sh

mkdir -p /home/auth/logs/ 

if ! test -f /engines/var/run/flags/first_run.done
  then
	/home/first_run.sh		
	touch /engines/var/run/flags/first_run.done
 fi
	
#echo dbflavor=$dbflavor >/home/auth/.dbenv
#echo dbhost=$dbhost >>/home/auth/.dbenv
#echo dbname=$dbname >>/home/auth/.dbenv
#echo dbpasswd=$dbpasswd >>/home/auth/.dbenv
#echo dbuser=$dbuser >>/home/auth/.dbenv

#chmod og-rwx  /home/auth/.dbenv




SIGNAL=0
sudo -n /home/engines/scripts/_start_syslog.sh
#sudo -n /home/_start_sshd.sh
sudo -n /home/_start_kerobos.sh 


while test $SIGNAL -ne 3 -a $SIGNAL -ne 15
do
 if test -f $PID_FILE
 	then
 	echo "waiting"
 	sleep 500 &
		wait 
		#echo $SIGNAL
 fi
done

sudo /home/engines/scripts/_kill_syslog.sh
rm -f /engines/var/run/flags/startup_complete
exit $exit_code