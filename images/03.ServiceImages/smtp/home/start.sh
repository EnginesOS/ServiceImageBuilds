#!/bin/sh

#if ! test -f /home/engines/run/flags/first_run
#  then
#  /home/engines/scripts/first_run/first_run.sh
# if test $? -eq 0
#  then
#  	touch /home/engines/run/flags/first_run
#  fi
#fi

PID_FILE=/tmp/sleep.pid
export PID_FILE

KILL_SCRIPT=/home/engines/scripts/signal/kill_sleep.sh
export KILL_SCRIPT

. /home/engines/functions/trap.sh

service_first_run_check



/home/engines/scripts/startup/init_dbs.sh
sudo -n /home/engines/scripts/startup/_start_postfix.sh



