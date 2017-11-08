#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="parent_engine container_type"
check_required_values
export parent_engine container_type
	
sudo -n /home/engines/scripts/actionators/_rm_service.sh
