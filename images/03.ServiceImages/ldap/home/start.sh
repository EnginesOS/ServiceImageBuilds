#!/bin/sh


#if ! test -f /home/engines/run/flags/first_run
#  then
#    sudo -n /home/engines/scripts/first_run/_first_run.sh
#  fi
#


PID_FILE=/tmp/pids
export PID_FILE
. /home/engines/functions/trap.sh

service_first_run_check


sudo -n /home/engines/scripts/startup/_start_slapd.sh

exit_code=$?

exit $exit_code

