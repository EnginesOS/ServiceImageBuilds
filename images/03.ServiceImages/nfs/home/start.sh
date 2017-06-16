#!/bin/sh

sudo -n /home/engines/scripts/_start_syslog.sh



PID_FILE=/var/run/ganesha.pid
export PID_FILE
. /home/engines/functions/trap.sh

mkdir -p /engines/var/run/flags

		
sudo -n /etc/init.d/rpcbind start

sudo  -n /usr/bin/ganesha.nfsd  -L /var/log/ganesha.log -F -f /usr/local/etc/ganesha.conf &
touch  /engines/var/run/flags/startup_complete
wait  
exit_code=$?
rm /engines/var/run/flags/startup_complete
sudo -n /home/engines/scripts/_kill_syslog.sh
exit $exit_code




