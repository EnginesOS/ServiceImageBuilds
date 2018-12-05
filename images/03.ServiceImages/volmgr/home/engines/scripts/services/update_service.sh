#!/bin/sh
#. /home/engines/functions/params_to_env.sh
#params_to_env
 . /home/engines/functions/checks.sh

required_values="parent_engine service_name user group"
check_required_values

export parent_engine
export service_name
export user
export group
export grp_write

sudo -n /home/engines/scripts/services/_update_service.sh
