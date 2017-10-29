#!/bin/sh

PID_FILE=/var/run/ganesha.pid
export PID_FILE
. /home/engines/functions/trap.sh

mkdir -p /home/engines/run/flags

		
sudo -n /etc/init.d/rpcbind start

sudo  -n /usr/bin/ganesha.nfsd  -L /var/log/ganesha.log -F -f /usr/local/etc/ganesha.conf &
touch  /home/engines/run/flags/startup_complete
wait  
exit_code=$?
rm /home/engines/run/flags/startup_complete

exit $exit_code




