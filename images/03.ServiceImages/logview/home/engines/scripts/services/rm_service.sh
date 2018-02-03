#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="log_name"
check_required_values
log_name=`echo $log_name | sed "/ /s//_/g"`
config_file=/home/app/config.user.d/${container_type}s/$parent_engine/$log_name.json
rm $config_file
#/home/engines/scripts/services/build_config.sh
