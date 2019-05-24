#!/bin/sh
 . /home/engines/functions/checks.sh
required_values="common_name cert_type fqdn"
check_required_values


err=`sudo -n /home/engines/scripts/engine/sudo/_install_target.sh services/wap ${cert_type} ${common_name} ${fqdn}`
r=$?
 if test $r -ne 0
  then
  	echo '{"Result":"Failed","ErrorMesg":"'$err'","ExitCode":"'$r'"}'
  else 
	echo '{"Result":"Success"}'
fi
exit $r
