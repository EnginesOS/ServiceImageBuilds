#!/bin/bash


service_hash=`echo  "$*" | sed "/\*/s//STAR/g"`

. /home/engines/scripts/functions.sh

load_service_hash_to_environment

#FIXME make engines.internal settable

openssl genrsa -out  /home/store/keys/${cert_name}.key 2048

echo $person >/home/saved/${cert_name}_setup
echo $organisation >>/home/saved/${cert_name}_setup
echo $city >>/home/saved/${cert_name}_setup
echo $state >>/home/saved/${cert_name}_setup
echo $country >>/home/saved/${cert_name}_setup
echo \*.$domainname  >>/home/saved/${cert_name}_setup
echo "" >>/home/saved/${cert_name}_setup
echo "" >>/home/saved/${cert_name}_setup

openssl req -new -key /home/store/keys/${cert_name}.key -out /home/saved/${cert_name}.csr < /home/saved/${cert_name}_setup
openssl x509 -req -in /home/saved/${cert_name}.csr -CA /home/certs/store/ca/system_CA.pem -CAkey /home/certs/store/ca/system_CA.key -CAcreateserial -out /home/certs/store/certs/${cert_name}.crt -days 500

echo "Success"
exit 0
