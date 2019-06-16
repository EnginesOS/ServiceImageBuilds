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
 if ! test -f $StoreRoot/private/ca/keys/${ca_name}_CA.key
  then
    echo '{"status":"error","message":"No Such CA '$ca_name'"}'
    exit 2
  fi
rm $StoreRoot/private/ca/keys/${ca_name}_CA.key
rm $StoreRoot/public/ca/certs/${ca_name}_CA.pem
