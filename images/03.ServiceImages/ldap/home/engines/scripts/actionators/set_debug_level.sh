#!/bin/sh
 . /home/engines/functions/checks.sh
required_values="debug_level"
check_required_values

echo -n $debug_level > /home/engines/run/flags/debug_level
exit 0
