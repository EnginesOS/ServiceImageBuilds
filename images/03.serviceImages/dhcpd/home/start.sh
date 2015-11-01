#!/bin/sh
mkdir -p /engines/var/run/flags/


PID_FILE=/var/run/dhcpd.pid
export PID_FILE

. /home/trap.sh
touch /tmp/start_dhcpd

while test -f /tmp/start_dhcpd
 do
   rm /tmp/start_dhcpd  
if ! test -f /etc/dhcp/dhcpd.conf
   then		
	touch /engines/var/run/flags/wait_for_dhcpd.conf
	echo $$ > /var/run/dhcpd.pid
	while ! test -f /etc/dhcp/dhcpd.conf
		do		 
		sleep 60 &
		wait
	done 	
   fi
rm /var/run/dhcpd.pid
rm /engines/var/run/flags/wait_for_dhcpd.conf
sudo -n syslogd  -R syslog.engines.internal:5140
sudo -n /usr/sbin/dhcpd  -cf /etc/dhcp/dhcpd.conf -pf /var/run/dhcpd.pid  -f & 
#Handle Crash Service must stay up for configurator
sleep 2 
if ! test -f /var/run/dhcpd.pid
then
	sudo /home/clear_dhcpd_conf.sh
	touch /tmp/start_dhcpd
else
	touch /engines/var/run/flags/startup_complete
	wait  
 fi
	   
done 

rm /engines/var/run/flags/startup_complete


