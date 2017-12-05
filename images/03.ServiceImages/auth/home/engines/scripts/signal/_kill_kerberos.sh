#!/bin/sh

PID_FILES="/var/run/krb5kdc.pid /var/run/krb5admin.pid"

. /home/engines/functions/signals.sh

SIGNAL=$1

default_signal_processor

exit 0
