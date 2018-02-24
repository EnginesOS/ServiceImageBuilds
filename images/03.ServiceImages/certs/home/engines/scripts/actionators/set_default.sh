#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env
set >/tmp/set_default
required_values="common_name cert_type install_target"
check_required_values
echo "set default" /_install_target.sh ${install_target} ${cert_type} ${common_name}
if ! test -z $cert_src
 then
  common_name=$cert_src/${common_name}
fi
 
/home/engines/scripts/engine/set_default.sh ${install_target} ${cert_type} ${common_name} 