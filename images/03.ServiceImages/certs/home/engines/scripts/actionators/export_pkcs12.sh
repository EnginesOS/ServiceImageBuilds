#!/bin/sh
 . /home/engines/functions/checks.sh
. /home/engines/scripts/engine/cert_dirs.sh

required_values="common_name cert_type export_password"
check_required_values
#if test $cert_type = generated
#then
#  store=generated 
#elif test $cert_type = user
# then
#  store=user   
#elif test $cert_type = imported
# then
#   store=imported
#elif test $cert_type = external_ca
# then
#   store=external_ca
#fi  
resolve_cert_dir
resolve_key_dir
  
if test -f $cert_dir$/{common_name}.crt
  then
  openssl pkcs12 -export -passout pass:$export_password -inkey $key_dir/${common_name}.key -in $cert_dir/${common_name}.crt  
  else
 	echo "Not Such Cert $cert_dir/${common_name}.crt"
 	exit 2
fi

exit 0
