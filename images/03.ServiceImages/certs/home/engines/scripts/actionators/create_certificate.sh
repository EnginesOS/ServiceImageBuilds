#!/bin/sh

 . /home/engines/functions/checks.sh
. /home/engines/scripts/engine/cert_dirs.sh
. $CERT_DEFAULTS_FILE
if test -z $country
 then
  $country=$_country
fi
if test -z $state
 then
  $state=$_state
fi  
if test -z $city
 then
  $city=$_city
fi
if test -z $person
 then
  $person=$_person
fi
if test -z $organisation
 then
  $organisation=$_organisation
fi


set >/tmp/create_cert
required_values=" common_name country state city organisation person"
check_required_values


cert_type=user
export cert_name common_name country state city organisation person wild alt_names hostname cert_type ca_name

err=`/home/engines/scripts/engine/create_cert.sh`

r=$?
 if test $r -ne 0
    then
  	 echo '{"Result":"Failed","ErrorMesg":"'$err'","ExitCode":"'$r'"}'
   else 
	 echo '{"Result":"Success"}'
  fi
exit $r
