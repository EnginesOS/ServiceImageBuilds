#!/bin/sh


required_values="fqdn  cert_location"

check_required_values

if test $cert_location = user
 then
  path=/generated/certs/user/$fqdn
 elif test $cert_location = live
  then 
   required_values="fqdn  cert_location consumer_type consumer_name"
   check_required_values
    path=/live/${consumer_type}s/$consumer_name/certs/$fqdn
 elif test $cert_location = imported
  then
   path=/imported/certs/$fqdn
 elif test $cert_location = generated
  then  
   required_values="fqdn cert_location consumer_type consumer_name"
   check_required_values
   path=/generated/certs/${consumer_type}s/$consumer_name/$fqdn
fi  

  
if test -f /home/certs/store/$path.crt
  then
 	cat /home/certs/store/$path.crt | openssl x509 -text
  else
 	echo "Not Such Cert $path.crt"
 	exit 127
fi

exit 0
