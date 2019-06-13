#!/bin/sh

PID_FILE=/home/engines/run/ftpd.pid
export PID_FILE
. /home/engines/functions/trap.sh

/home/engines/scripts/engine/init_ldap_config.sh
sudo -n /home/engines/scripts/startup/sudo/_startup.sh
sudo -n /usr/sbin/proftpd -n &

startup_complete



wait 
exit_code=$?

shutdown_complete
