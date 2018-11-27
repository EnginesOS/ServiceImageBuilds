#!/bin/sh


 . /home/engines/functions/checks.sh

required_values="log_name"
check_required_values
log_name=`echo $log_name | sed "/ /s//_/g"`
config_file=/home/app/config.user.d/${container_type}s/$parent_engine/$log_name.json
#file might not exist if it was rejected due to missing log file
if test -f $config_file
  then
	rm $config_file
fi	
#/home/engines/scripts/services/build_config.sh
