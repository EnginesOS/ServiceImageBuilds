#!/bin/sh

 . /home/engines/functions/checks.sh

if test ca_name = system
 then
  echo '{"status":"error","message":"Cannot remove System CA"}'
  exit 2
 fi 

required_values="ca_name"
check_required_values


. /home/engines/scripts/engine/cert_dirs.sh
. $StoreRoot/$ca_name/${ca_name}.meta

if test $cert_type = generated
 then
 echo '{"status":"error","message":"Cannot remove System Generated CA"}'
 exit 2  
fi

 if ! test -f $StoreRoot/private/$ca_name/${ca_name}_CA.key
  then
    echo '{"status":"error","message":"No Such CA '$ca_name'"}'
    exit 2
  fi 
rm -r $StoreRoot/private/$ca_name/
rm $StoreRoot/public/ca/certs/${ca_name}_*

rm -r $StoreRoot/$ca_name
