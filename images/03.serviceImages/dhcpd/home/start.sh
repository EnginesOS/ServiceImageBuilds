#!/bin/sh
mkdir -p /engines/var/run/flags/


 PID_FILE=/var/run/dhcpd.pid
export PID_FILE

. /home/trap.sh

if ! test -f /etc/dhcpd/dhcpd.conf
   then		
	touch /engines/var/run/flags/wait_for_dhcpd.conf
	echo $$ > /var/run/dhcpd.pid
	while ! test -f /etc/dhcpd/dhcpd.conf
		do		 
		sleep 60 &
		wait
	done 	
   fi

rm /engines/var/run/flags/wait_for_dhcpd.conf
sudo -n syslogd  -R syslog.engines.internal:5140
sudo -n /usr/sbin/dhcpd  -cf /etc/dhcpd/dhcpd.conf -pf /var/run/dhcpd.pid  -f & 
touch /engines/var/run/flags/startup_complete
wait  
 
if test -f /tmp/restart_dhcp
 then
   /home/start.sh
fi

rm /engines/var/run/flags/startup_complete


