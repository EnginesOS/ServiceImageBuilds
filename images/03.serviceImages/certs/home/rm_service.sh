#!/bin/bash


service_hash=`echo  "$1" | sed "/\*/s//STAR/g"`
. /home/engines/scripts/functions.sh

load_service_hash_to_environment


if test -z "${cert_name}"
	then
		echo Error:Missing cert_name
        exit -1
    fi
 
 #FIXME make revocate   in crl
 
 rm /home/store/keys/${cert_name}.key /home/saved/${cert_name}.csr  /home/certs/store/certs/${cert_name}.crt
 
echo "Success"
exit 0

