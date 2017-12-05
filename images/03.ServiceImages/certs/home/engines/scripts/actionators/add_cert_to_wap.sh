#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env


required_values="cert_name store fqdn"
check_required_values



err=`sudo -n  /home/engines/scripts/engine/_install_target.sh wap ${store}/${cert_name} ${fqdn}`
r=$?
 if $r -ne 0
  then
  	echo '{"Result":"Failed","ErrorMesg":"'$err'","ExitCode":"'$r'"}'
  else 
	echo '{"Result":"Success"}'
fi
exit $r
