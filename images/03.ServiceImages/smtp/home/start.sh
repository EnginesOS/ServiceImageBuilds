#!/bin/sh

if ! test -f /engines/var/run/flags/first_run
  then
  /home/engines/scripts/first_run/first_run.sh
 if test $? -eq 0
  then
  	touch /engines/var/run/flags/first_run
  fi
fi

PID_FILE=/var/spool/postfix/pid/master.pid

KILL_SCRIPT=/home/engines/scripts/signal/kill_postfix.sh
export KILL_SCRIPT

export PID_FILE
. /home/engines/functions/trap.sh

sudo -n /home/engines/scripts/_start_syslog.sh

echo started syslog

/home/engines/scripts/startup/init_dbs.sh
sudo -n /home/engines/scripts/startup/_start_postfix.sh



