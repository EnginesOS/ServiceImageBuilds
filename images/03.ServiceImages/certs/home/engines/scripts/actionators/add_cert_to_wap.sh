#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env


required_values="common_name cert_type fqdn"
check_required_values



err=`sudo -n /home/engines/scripts/engine/_install_target.sh services/wap ${cert_type} ${cert_name} ${fqdn}`
r=$?
 if test $r -ne 0
  then
  	echo '{"Result":"Failed","ErrorMesg":"'$err'","ExitCode":"'$r'"}'
  else 
	echo '{"Result":"Success"}'
fi
exit $r
