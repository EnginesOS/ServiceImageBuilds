#!/bin/bash


service_hash=$1


#. /home/engines/scripts/functions.sh

#load_service_hash_to_environment

 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

#FIXME make engines.internal settable
if test -z "${cert_name}"
	then
		echo Error:Missing cert_name
        exit -1
    fi
    
    mkdir -p /home/certs/store/public/keys/
    mkdir -p /home/certs/store/public/certs
    
openssl genrsa -out  /home/certs/store/public/keys/${cert_name}.key.tmp 2048

echo $country >/home/certs/saved/${cert_name}_setup
echo $state >>/home/certs/saved/${cert_name}_setup
echo $city >>/home/certs/saved/${cert_name}_setup
echo $organisation >>/home/certs/saved/${cert_name}_setup
echo $person >>/home/certs/saved/${cert_name}_setup
echo \*.$domainname  >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup
openssl req -new -key /home/certs/store/public/keys/${cert_name}.key.tmp -out /home/certs/saved/${cert_name}.csr < /home/certs/saved/${cert_name}_setup
if test $? -ne 0
 then
 	echo "Failed to Create CSR"
 	exit 127
 fi
openssl x509 -req -in /home/certs/saved/${cert_name}.csr -CA  /home/certs/store/public/ca/certs/system_CA.pem -CAkey /home/certs/store/private/ca/keys/system_CA.key -CAcreateserial -out /home/certs/store/public/certs/${cert_name}.crt.tmp -days 500
if test $? -ne 0
 then
 	echo "Failed to sign CSR"
 	exit 127
 fi
  if test -f  /home/certs/store/public/keys/${cert_name}.key.tmp -a -f /home/certs/store/public/certs/${cert_name}.crt.tmp
   then
    mv /home/certs/store/public/keys/${cert_name}.key.tmp /home/certs/store/public/keys/${cert_name}.key
    mv /home/certs/store/public/certs/${cert_name}.crt.tmp /home/certs/store/public/certs/${cert_name}.crt
   else
    echo "Cert and Key files not present"
    exit 127
   fi
echo "Success"
exit 0
