#!/bin/sh

PID_FILES="/home/engines/run/krb5kdc.pid /home/engines/run/krb5admin.pid"

. /home/engines/functions/signals.sh

SIGNAL=$1

default_signal_processor

exit 0
