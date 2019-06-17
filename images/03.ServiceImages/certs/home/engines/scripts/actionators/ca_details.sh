#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
 . /home/engines/functions/checks.sh
required_values=" ca_name"
check_required_values

if test -f $StoreRoot/public/ca/certs/${ca_name}_CA.pem
  then
 	cat $StoreRoot/public/ca/certs/${ca_name}_CA.pem | openssl x509 -text
  else
 	echo "Not Such Cert $StoreRoot/public/ca/certs/${ca_name}_CA.pem"
 	exit 1
fi