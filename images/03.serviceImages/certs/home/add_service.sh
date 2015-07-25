#!/bin/bash


service_hash=`echo  "$*" | sed "/\*/s//STAR/g"`

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

#FIXME make engines.internal settable
if test -z "${cert_name}"
	then
		echo Error:Missing cert_name
        exit -1
    fi
openssl genrsa -out  /home/certs/store/public/keys/${cert_name}.key 2048

echo $country >/home/certs/saved/${cert_name}_setup
echo $state >>/home/certs/saved/${cert_name}_setup
echo $city >>/home/certs/saved/${cert_name}_setup
echo $organisation >>/home/certs/saved/${cert_name}_setup
echo $person >>/home/certs/saved/${cert_name}_setup
echo \*.$domainname  >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup
openssl req -new -key /home/certs/store/public/keys/${cert_name}.key -out /home/certs/saved/${cert_name}.csr < /home/certs/saved/${cert_name}_setup
openssl x509 -req -in /home/certs/saved/${cert_name}.csr -CA /home/certs/store/public/ca/certs/system_CA.pem -CAkey /home/certs/store/private/ca/keys/system_CA.key -CAcreateserial -out /home/certs/store/public/certs/${cert_name}.crt -days 500

echo "Success"
exit 0
