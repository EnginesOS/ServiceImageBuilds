#!/bin/sh

#if ! test -f /engines/run/flags/first_run_done
# then
#   /home/engines/scripts/first_run/first_run.sh
#   touch /engines/run/flags/first_run_done
#fi
  
PID_FILE=/var/run/engines/apache.pid
export PID_FILE
. /home/engines/functions/trap.sh

service_first_run_check

mkdir /var/log/apache2
  
 

/usr/sbin/apache2ctl -DFOREGROUND &	

echo $? > /var/run/engines/apache.pid
touch  /home/engines/run/flags/startup_complete

wait
exit_code=$?

rm /home/engines/run/flags/startup_complete
exit $exit_code