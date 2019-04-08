#!/bin/sh

 . /home/engines/functions/checks.sh
required_values="common_name  cert_location"
. /home/engines/scripts/engine/cert_dirs.sh

check_required_values

if test $cert_location = user
 then
  path=/generated/certs/user/$common_name
 elif test $cert_location = live
  then 
   required_values="common_name  cert_location consumer_type consumer_name"
   check_required_values
    path=/live/${consumer_type}s/$consumer_name/certs/$common_name
 elif test $cert_location = imported
  then
   path=/imported/certs/$common_name
 elif test $cert_location = generated
  then  
   required_values="common_name cert_location consumer_type consumer_name"
   check_required_values
   path=/generated/certs/${consumer_type}s/$consumer_name/$common_name
fi  

  
if test -f $StoreRoot/$path.crt
  then
 	cat $StoreRoot/$path.crt | openssl x509 -text
  else
 	echo "Not Such Cert $path.crt"
 	exit 1
fi

exit 0
