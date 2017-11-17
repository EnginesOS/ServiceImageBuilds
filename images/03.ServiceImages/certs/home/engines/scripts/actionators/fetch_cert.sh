#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="cert_name store"
check_required_values


if test -f /home/certs/store/public/certs/${store}/${cert_name}.crt
  then
 	cat /home/certs/store/public/certs/${store}/${cert_name}.crt
  else
 	echo "Not Such Cert ${store}/${cert_name}.crt"
 	exit 255
fi

exit
 	
