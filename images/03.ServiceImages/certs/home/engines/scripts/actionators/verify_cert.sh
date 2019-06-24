#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
 . /home/engines/functions/checks.sh
required_values="ca_name certificate"
echo $certificate  | tr '\r' '\n' | sed "/^ /s///" > /tmp/certificate
check_required_values

if test -f $StoreRoot/public/ca/certs/${ca_name}_CA_CRL.pem 
  then
       openssl verify -crl_check \
       				-CAfile $StoreRoot/public/ca/certs/${ca_name}_CA_CRL.pem \
       				/tmp/certificate | sed "/\/tmp\//s///"     
      rm /tmp/certificate
  else
 	echo "Missing $StoreRoot/public/ca/certs/${ca_name}_CA_CRL.pem" 
 	exit 2
fi