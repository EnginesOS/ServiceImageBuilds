#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z ${cert_name}
 then
  echo Missig cert_name
  exit 255
fi

if test -f /home/certs/store/public/certs/${cert_name}.crt
 then
 	rm /home/certs/store/public/certs/${cert_name}.crt
 else
 	echo "Not Such Cert ${cert_name}.crt"
 	exit 255
fi
 	
if test -f /home/certs/store/public/keys/${cert_name}.key
 then
 	rm /home/certs/store/public/keys/${cert_name}.key
 else
 	echo "No Such key ${cert_name}.key"
 	exit 255
fi

echo true
exit
 	
