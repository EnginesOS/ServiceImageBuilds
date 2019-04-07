#!/bin/sh
 . /home/engines/functions/checks.sh
. /home/engines/scripts/engine/cert_dirs.sh

required_values="common_name "
check_required_values
if test $cert_type = generated
then
  store=/certs/${owner_type}s/$owner/
  if test $owner_type = service
   then
     cert_type=live
     store=${owner_type}s/$owner/certs/
  fi   
elif test $cert_type = user
 then
  cert_type=generated 
  store=user
elif test   $cert_type = live
 then
   store=${owner_type}s/$owner/certs/
fi  

  
if test -f $StoreRoot/$cert_type/${store}/${common_name}.crt
  then
 	cat $StoreRoot/$cert_type/${store}/${common_name}.crt
  else
 	echo "Not Such Cert $StoreRoot/$cert_type/${store}/${common_name}.crt"
 	exit 1
fi

exit 0
