#!/bin/sh

PID_FILE=/home/engines/run/ganesha.pid
export PID_FILE
. /home/engines/functions/trap.sh
		
sudo -n /etc/init.d/rpcbind start

sudo  -n /usr/bin/ganesha.nfsd  -L /var/log/ganesha.log -F -f /usr/local/etc/ganesha.conf &

startup_complete

wait  
exit_code=$?

shutdown_complete




