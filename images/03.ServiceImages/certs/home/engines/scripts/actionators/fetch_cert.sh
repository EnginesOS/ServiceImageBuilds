#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

if test -z ${cert_name}
 then
  echo Missig cert_name
  exit 255
fi
 
 if test -z ${store}
 then
  echo Missing store
  exit 255
fi

if test -f /home/certs/store/public/certs/${store}/${cert_name}.crt
  then
 	cat /home/certs/store/public/certs/${store}/${cert_name}.crt
  else
 	echo "Not Such Cert ${store}/${cert_name}.crt"
 	exit 255
fi

exit
 	
