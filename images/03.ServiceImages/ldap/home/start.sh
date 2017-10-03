#!/bin/sh


if ! test -f /engines/var/run/flags/first_run
  then
    sudo -n /home/_first_run.sh
  fi


PID_FILE=/tmp/pids
export PID_FILE
. /home/engines/functions/trap.sh


sudo -n /home/engines/scripts/_start_syslog.sh

echo started syslog


sudo -n /home/_start_slapd.sh

exit_code=$?


sudo -n /home/engines/scripts/_kill_syslog.sh
exit $exit_code

