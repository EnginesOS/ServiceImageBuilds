#!/bin/sh

PID_FILE=/home/engines/run/dhcpd.pid
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
rm /home/engines/run/dhcpd.pid


sudo -n /usr/sbin/dhcpd  -cf /etc/dhcp/dhcpd.conf -pf $PID_FILE  -f & 

startup_complete

wait  
exit_code=$?

shutdown_complete



