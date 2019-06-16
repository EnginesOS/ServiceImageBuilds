#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh

if test -f $StoreRoot/public/ca/certs/${ca_name}_CA.pem
  then
 	cat $StoreRoot/public/ca/certs/${ca_name}_CA.pem | openssl x509 -text
  else
 	echo "Not Such Cert $StoreRoot/public/ca/certs/${ca_name}_CA.pem"
 	exit 1
fi