#!/bin/sh
 . /home/engines/functions/checks.sh
. /home/engines/scripts/engine/cert_dirs.sh

required_values="common_name  export_password"
check_required_values

resolve_cert_dir
resolve_key_dir
  
if test -f $cert_dir/${common_name}.crt
  then
  openssl pkcs12 -export -passout pass:$export_password -inkey $key_dir/${common_name}.key -in $cert_dir/${common_name}.crt  
  else
 	echo '{"status":"error","message":"Not Such Cert '$cert_dir/${common_name}'.crt"}'
 	exit 2
fi

exit 0
