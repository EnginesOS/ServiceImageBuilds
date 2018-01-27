#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="cert_name store cert_type"
check_required_values

if test $cert_type = user
 then
  cert_type=generated 
  store=user
fi  

  
if test -f /home/certs/store/$cert_type/certs/${store}/${cert_name}.crt
  then
 	cat /home/certs/store/$cert_type/certs/${store}/${cert_name}.crt
  else
 	echo "Not Such Cert $cert_type/${store}/${cert_name}.crt"
 	exit 127
fi

exit 0
