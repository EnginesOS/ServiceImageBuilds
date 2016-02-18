#!/bin/sh
mkdir -p /engines/var/run/flags/


PID_FILE=/var/run/dhcpd.pid
export PID_FILE

. /home/trap.sh
touch /tmp/start_dhcpd

  
if ! test -f /etc/dhcp/dhcpd.conf
   then		
echo "Not configured"
exit
   fi
rm /var/run/dhcpd.pid

sudo -n syslogd  -R syslog.engines.internal:514
sudo -n /usr/sbin/dhcpd  -cf /etc/dhcp/dhcpd.conf -pf /var/run/dhcpd.pid  -f & 

	touch /engines/var/run/flags/startup_complete
	wait  


rm /engines/var/run/flags/startup_complete


