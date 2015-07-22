#!/bin/bash


service_hash=`echo  "$*" | sed "/\*/s//STAR/g"`

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

#FIXME make engines.internal settable

openssl genrsa -out  /home/certs/store/keys/${cert_name}.key 2048

echo $person >/home/certs/saved/${cert_name}_setup
echo $organisation >>/home/certs/saved/${cert_name}_setup
echo $city >>/home/certs/saved/${cert_name}_setup
echo $state >>/home/certs/saved/${cert_name}_setup
echo $country >>/home/certs/saved/${cert_name}_setup
echo \*.$domainname  >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup

openssl req -new -key /home/certs/store/keys/${cert_name}.key -out /home/certs/saved/${cert_name}.csr < /home/certs/saved/${cert_name}_setup
openssl x509 -req -in /home/certs/saved/${cert_name}.csr -CA /home/certs/store/ca/system_CA.pem -CAkey /home/certs/store/ca/system_CA.key -CAcreateserial -out /home/certs/store/certs/${cert_name}.crt -days 500

echo "Success"
exit 0
