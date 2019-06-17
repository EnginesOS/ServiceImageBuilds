#!/bin/sh

 . /home/engines/functions/checks.sh
. /home/engines/scripts/engine/cert_dirs.sh

if test $cert_location = live
  then 
   required_values="common_name ca_name cert_type consumer_type consumer_name"
else
  required_values="common_name ca_name"
fi   

check_required_values

. /home/engines/scripts/engine/cert_dirs.sh



consumer_type=$owner_type
consumer_name=$owner
resolve_cert_dir

 
  
if test -f $cert_dir/$common_name.crt
  then
 	cat $cert_dir/$common_name.crt | openssl x509 -text
  else
 	echo "Not Such Cert $cert_dir/$common_name.crt"
 	exit 1
fi

exit 0
