#!/bin/sh


PID_FILES="/var/spool/postfix/pid/master.pid /tmp/sleep.pid"
. /home/engines/functions/signals.sh

default_signal_processor
exit 0
