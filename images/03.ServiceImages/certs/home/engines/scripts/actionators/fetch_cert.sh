#!/bin/sh
 . /home/engines/functions/checks.sh
. /home/engines/scripts/engine/cert_dirs.sh
if test $cert_location = live
  then 
   required_values="common_name  cert_type consumer_type consumer_name"
elif test $cert_location = generated
  then  
   required_values="common_name cert_type consumer_type consumer_name"
else
  required_values="common_name  cert_type"
fi   

check_required_values

#if test $cert_type = generated
#then
#  store=/certs/${owner_type}s/$owner/
#  if test $owner_type = service
#   then
#     cert_type=live
#     store=${owner_type}s/$owner/certs/
#  fi   
#elif test $cert_type = user
# then
#  cert_type=user
#elif test $cert_type = live
# then
#   store=${owner_type}s/$owner/certs/
#elif test $cert_type = external_ca
#then
#store=/certs/
#fi  
resolve_cert_dir
  
if test -f $cert_dir/${common_name}.crt
  then
 	cat $cert_dir/${common_name}.crt
  else
 	echo "Not Such Cert $cert_dir/${common_name}.crt"
 	exit 1
fi

exit 0
