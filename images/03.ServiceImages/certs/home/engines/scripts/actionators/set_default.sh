#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="cert_name cert_type target"
check_required_values
echo "set default" /_install_target.sh ${target} ${cert_type} ${cert_name} 
sudo -n  /home/engines/scripts/engine/set_default.sh ${target} ${cert_type} ${cert_name} 