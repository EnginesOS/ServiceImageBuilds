#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="log_name"
check_required_values

#rm /home/saved/$parent_engine/$log_name
rm /home/app/config.user.d/${ctype}s/$parent_engine/$log_name
#/home/engines/scripts/services/build_config.sh
