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
sudo /usr/sbin/ipsec start --nofork &
iptables -t nat -I POSTROUTING -s 10.1.1.0/24 -o eth+ -j MASQUERADE
iptables -t nat -I POSTROUTING -s  10.1.1.0/24 -o eth+ -m policy --dir out --pol none -j MASQUERADE

wait 
sleep 500
sudo -n  /home/engines/scripts/_kill_syslog.sh
rm -f /engines/var/run/flags/startup_complete
