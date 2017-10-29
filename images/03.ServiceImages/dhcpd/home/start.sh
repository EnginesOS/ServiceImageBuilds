#!/bin/sh

PID_FILE=/var/run/dhcpd.pid
export PID_FILE
KILL_SCRIPT=/home/engines/scripts/signal/_signal.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh
touch /tmp/start_dhcpd

  
if ! test -f /etc/dhcp/dhcpd.conf
   then		
     echo "Not configured"
     exit
fi
rm /var/run/dhcpd.pid


sudo -n /usr/sbin/dhcpd  -cf /etc/dhcp/dhcpd.conf -pf /var/run/dhcpd.pid  -f & 

touch /home/engines/run/flags/startup_complete
wait  
exit_code=$?
rm /home/engines/run/flags/startup_complete
exit $exit_code


