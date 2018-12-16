#!/bin/sh
 . /home/engines/functions/checks.sh

required_values="common_name cert_type"
check_required_values
if test $cert_type = generated
then
  store=${owner_type}s/$owner/
elif test $cert_type = user
 then
  cert_type=generated 
  store=user
fi  

  
if test -f /home/certs/store/$cert_type/certs/${store}/${common_name}.crt
  then
 	cat /home/certs/store/$cert_type/certs/${store}/${common_name}.crt
  else
 	echo "Not Such Cert $cert_type/${store}/${common_name}.crt"
 	exit 1
fi

exit 0
