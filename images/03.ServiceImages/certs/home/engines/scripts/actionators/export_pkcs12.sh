#!/bin/sh
 . /home/engines/functions/checks.sh
. /home/engines/scripts/engine/cert_dirs.sh

required_values="common_name "
check_required_values
if test $cert_type = generated
then
  store=generated 
elif test $cert_type = user
 then
  cert_type=generated 
  store=user
elif test   $cert_type = imported
 then
   store=external_ca
fi  

  
if test -f $StoreRoot/${store}/certs/${common_name}.crt
  then
  openssl pkcs12 -export - -passout pass:$export_password -inkey $StoreRoot/${store}/keys/${common_name}.key -in $StoreRoot/${store}/certs/${common_name}.crt
  else
 	echo "Not Such Cert $StoreRoot/$cert_type/${store}/${common_name}.crt"
 	exit 1
fi

exit 0
