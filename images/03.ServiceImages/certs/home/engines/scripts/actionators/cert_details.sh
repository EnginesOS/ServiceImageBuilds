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

. /home/engines/scripts/engine/cert_dirs.sh



consumer_type=$owner_type
consumer_name=$owner
resolve_cert_dir

#if test $cert_location = user
# then
#  path=/generated/certs/user/$common_name
# elif test $cert_location = live
#  then 
#   required_values="common_name  cert_location consumer_type consumer_name"
#   check_required_values
#    path=/live/${consumer_type}s/$consumer_name/certs/$common_name
# elif test $cert_location = imported
#  then
#   path=/imported/certs/$common_name
# elif test $cert_location = generated
#  then  
#   required_values="common_name cert_location consumer_type consumer_name"
#   check_required_values
#   path=/generated/certs/${consumer_type}s/$consumer_name/$common_name
# elif test $cert_location = external_ca
#  then 
#   path=/external_ca/certs/$common_name
#fi  
#
  
if test -f $cert_dir/$common_name.crt
  then
 	cat $cert_dir/$common_name.crt | openssl x509 -text
  else
 	echo "Not Such Cert $cert_dir/$common_name.crt"
 	exit 1
fi

exit 0
