#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
 . /home/engines/functions/checks.sh
required_values=" ca_name"
check_required_values

if test -f $StoreRoot/public/ca/certs/${ca_name}_CRL.pem
  then
 	 openssl crl  -text -noout -in $StoreRoot/public/ca/certs/${ca_name}_CRL.pem 
  else
 	echo "Not Such Cert $StoreRoot/public/ca/certs/${ca_name}_CRL.pem"
 	exit 1
fi