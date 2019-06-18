#!/bin/sh
 . /home/engines/functions/checks.sh
. /home/engines/scripts/engine/cert_dirs.sh
if ! test -z $cert_type
 then
if test "$cert_type" = live
  then 
   required_values="common_name  cert_type consumer_type consumer_name"
else
  required_values="common_name ca_name"
  cert_type=""
fi    
 else
  required_values="common_name ca_name"
fi

check_required_values

resolve_cert_dir
  
if test -f $cert_dir/${common_name}.crt
  then
 	cat $cert_dir/${common_name}.crt
  else
 	echo "Not Such Cert $cert_dir/${common_name}.crt"
 	exit 1
fi

exit 0
