#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="debug_level"
check_required_values

echo -n $debug_level > /home/engines/run/flags/debug_level
exit 0
