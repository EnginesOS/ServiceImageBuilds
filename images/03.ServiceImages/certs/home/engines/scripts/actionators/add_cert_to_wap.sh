#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

install_target=wap

err=`sudo -n  /home/engines/scripts/engine/_install_target.sh wap ${StorePref}/${cert_name} ${fqdn}`
r=$?
 if $r -ne 0
  then
  	echo '{"Result":"Failed","ErrorMesg":"'$err'","ExitCode":"'$r'"}'
  else 
	echo '{"Result":"Success"}'
fi
exit $r
