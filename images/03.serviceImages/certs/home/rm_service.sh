#!/bin/bash


service_hash=$1


 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env

if test -z "${cert_name}"
	then
		echo Error:Missing cert_name
        exit -1
    fi
 
 #FIXME make revocate   in crl
 
 rm /home/certs/store/public/keys/${cert_name}.key /home/certs/saved/${cert_name}.csr  /home/certs/public/store/certs/${cert_name}.crt
 
echo "Success"
exit 0

