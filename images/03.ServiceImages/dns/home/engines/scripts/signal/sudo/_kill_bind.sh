#!/bin/sh


PID_FILES=" /home/engines/run/named.pid"
. /home/engines/functions/signals.sh

default_signal_processor
exit 0