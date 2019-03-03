#!/bin/sh
 . /home/engines/functions/checks.sh
. /home/engines/scripts/engine/cert_dirs.sh

required_values="common_name "
check_required_values
if test $cert_type = generated
then
  store=${owner_type}s/$owner/
elif test $cert_type = user
 then
  cert_type=generated 
  store=user
fi  

  
if test -f $StoreRoot/$cert_type/certs/${store}/${common_name}.crt
  then
 	cat $StoreRoot/$cert_type/certs/${store}/${common_name}.crt
  else
 	echo "Not Such Cert $cert_type/certs/${store}/${common_name}.crt"
 	exit 1
fi

exit 0
