#!/bin/sh
#echo kill -$1 cat $2
# kill -$1 `cat $2`

. /home/engines/functions/signals.sh

default_signal_processor
exit 0
