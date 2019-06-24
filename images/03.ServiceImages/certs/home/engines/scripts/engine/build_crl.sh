#!/bin/sh

ca_name=$1
. /home/engines/scripts/engine/cert_dirs.sh


openssl ca -gencrl  \
		-config $StoreRoot/private/$ca_name/open_ssl.cnf \
	 	-out $StoreRoot/public/ca/certs/${ca_name}_CRL.pem		 	

 if ! test -$? -eq 0
 then
  echo '{"status":"error","message":"Failed to create CA CRL '$StoreRoot/public/ca/certs/${ca_name}_CA.pem'" }'
  exit 3
fi 

cat $StoreRoot/public/ca/certs/${ca_name}_CA.pem \
		 		$StoreRoot/public/ca/certs/${ca_name}_CRL.pem \
		 		> $StoreRoot/public/ca/certs/${ca_name}_CA_CRL.pem 