#!/bin/sh

 . /home/engines/functions/checks.sh
required_values="common_name cert_type"
check_required_values
 
. /home/engines/scripts/engine/cert_dirs.sh
 

if test $cert_type = imported -o $cert_type = generated
 then
  echo "Cannot export key from cert type $cert_type"
  exit 1
fi  

resolve_key_dir

if test $cert_type = user
 then
  cert_type=user 
fi 

if test -f $key_dir/${common_name}.key
  then
 	cat $key_dir/${common_name}.key
  else
 	echo "Not Such key $key_dir/${common_name}.key"
 	exit 1
fi

exit 0
