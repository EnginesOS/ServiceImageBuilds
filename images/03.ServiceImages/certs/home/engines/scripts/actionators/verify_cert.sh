#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
 . /home/engines/functions/checks.sh
required_values=" ca_name cert"
echo $cert > /tmp/certificate
check_required_values

if test -f $StoreRoot/public/ca/certs/${ca_name}_CA_CRL.pem 
  then
      openssl verify -crl_check -CAfile $StoreRoot/public/ca/certs/${ca_name}_CA_CRL.pem  /tmp/certificate
      rm /tmp/certificate
  else
 	echo "Missing $StoreRoot/public/ca/certs/${ca_name}_CA_CRL.pem" 
 	exit 1
fi