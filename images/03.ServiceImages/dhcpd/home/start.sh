#!/bin/sh
mkdir -p /engines/var/run/flags/


PID_FILE=/var/run/dhcpd.pid
export PID_FILE

. /home/engines/functions/trap.sh
touch /tmp/start_dhcpd

  
if ! test -f /etc/dhcp/dhcpd.conf
   then		
echo "Not configured"
exit
   fi
rm /var/run/dhcpd.pid

sudo -n /home/engines/scripts/_start_syslog.sh

sudo -n /usr/sbin/dhcpd  -cf /etc/dhcp/dhcpd.conf -pf /var/run/dhcpd.pid  -f & 

	touch /engines/var/run/flags/startup_complete
	wait  


rm /engines/var/run/flags/startup_complete


