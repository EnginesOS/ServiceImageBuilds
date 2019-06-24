#!/bin/sh
 . /home/engines/functions/checks.sh
required_values="common_name ca_name install_target"
check_required_values
echo "set default" /_install_target.sh ${ca_name} ${common_name}  ${install_target}
if ! test -z $cert_src
 then
  common_name=$cert_src/${common_name}
fi
 
/home/engines/scripts/engine/set_default.sh  ${ca_name} ${common_name} ${install_target}