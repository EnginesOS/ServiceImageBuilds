#!/bin/bash
. /home/certs/store/default_cert_details

. /home/engines/functions/params_to_env.sh
params_to_env
set >/tmp/create_cert
required_values="cert_name common_name country state city organisation person"
check_required_values


cert_type=user
export cert_name common_name country state city organisation person wild alt_names hostname cert_type

err=`/home/engines/scripts/engine/create_cert.sh`

r=$?
 if test $r -ne 0
    then
  	 echo '{"Result":"Failed","ErrorMesg":"'$err'","ExitCode":"'$r'"}'
   else 
	 echo '{"Result":"Success"}'
  fi
exit $r
