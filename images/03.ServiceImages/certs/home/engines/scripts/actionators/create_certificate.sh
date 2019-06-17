#!/bin/sh

 . /home/engines/functions/checks.sh
. /home/engines/scripts/engine/cert_dirs.sh


set >/tmp/create_cert
required_values=" common_name country state city organisation person"
check_required_values

load_cert_defaults

cert_type=user
export cert_name common_name country state city organisation person wild alt_names hostname cert_type ca_name cert_usage

err=`/home/engines/scripts/engine/create_cert.sh`

r=$?
 if test $r -ne 0
    then
  	 echo '{"Result":"Failed","ErrorMesg":"'$err'","ExitCode":"'$r'"}'
   else 
	 echo '{"Result":"Success"}'
  fi
exit $r
