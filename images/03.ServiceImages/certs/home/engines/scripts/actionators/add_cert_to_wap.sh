#!/bin/sh
 . /home/engines/functions/checks.sh
required_values="common_name ca_name fqdn"
check_required_values


err=`sudo -n /home/engines/scripts/engine/sudo/_assign_certificate.sh ${ca_name} ${common_name} services/wap ${fqdn}`
r=$?
 if test $r -ne 0
  then
  	echo '{"Result":"Failed","ErrorMesg":"'$err'","ExitCode":"'$r'"}'
  else 
	echo '{"Result":"Success"}'
fi
exit $r
