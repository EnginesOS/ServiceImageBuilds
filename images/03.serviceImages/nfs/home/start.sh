#!/bin/sh

sudo syslogd -R syslog.engines.internal:5140


PID_FILE=/var/run/ganesha.pid
export PID_FILE
. /home/trap.sh

mkdir -p /engines/var/run/flags

		
sudo /etc/init.d/rpcbind start

sudo  /usr/bin/ganesha.nfsd  -L /var/log/ganesha.log -F -f /usr/local/etc/ganesha.conf &
touch  /engines/var/run/flags/startup_complete
wait  
rm /engines/var/run/flags/startup_complete
sudo /home/engines/scripts/_kill_syslog.sh




