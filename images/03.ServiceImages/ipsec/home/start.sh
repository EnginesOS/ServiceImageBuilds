#!/bin/sh


PID_FILE=/home/cron/fcron.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/
if ! test -f /etc/ipsec.d/private/ipvpn.key
 then
	sudo -n /home/setup.sh
fi

sudo -n /home/engines/scripts/_start_syslog.sh


touch /engines/var/run/flags/startup_complete  

sudo -n /home/_start.sh &

wait 
sleep 500
sudo -n  /home/engines/scripts/_kill_syslog.sh
rm -f /engines/var/run/flags/startup_complete
