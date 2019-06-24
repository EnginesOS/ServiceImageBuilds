#!/bin/sh
 . /home/engines/functions/checks.sh
required_values="common_name ca_name install_target_type install_target_name"
check_required_values
install_target=${install_target_type}s/${install_target_name}
echo "set default" /_install_target.sh ${ca_name} ${common_name} ${install_target}
 
/home/engines/scripts/engine/set_default.sh  ${ca_name} ${common_name} ${install_target}