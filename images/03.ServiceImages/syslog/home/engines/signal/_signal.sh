#!/bin/sh


PID_FILES="PID_FILE=/var/run/ng-syslog.pid"
. /home/engines/functions/signals.sh

default_signal_processor
exit 0
