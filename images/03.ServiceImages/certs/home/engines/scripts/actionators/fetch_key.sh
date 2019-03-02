#!/bin/sh

 . /home/engines/functions/checks.sh
required_values="common_name store cert_type"
check_required_values
 
. /home/engines/scripts/engines/certs_dirs.sh
 

if test $cert_type = imported -o $cert_type = generated
 then
  echo "Cannot export key from cert type $cert_type"
  exit 1
fi  

if test $cert_type = user
 then
  cert_type=generated 
  store=user
fi 

if test -f $StoreRoot/$cert_type/keys/${store}/${common_name}.key
  then
 	cat /$StoreRoot/$cert_type/keys/${store}/${common_name}.key
  else
 	echo "Not Such key $cert_type/${store}/${common_name}.key"
 	exit 1
fi

exit 0
