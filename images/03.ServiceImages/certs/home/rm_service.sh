#!/bin/bash

if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env>/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env

if test -z "${cert_name}"
	then
		echo Error:Missing cert_name
        exit -1
    fi
 
 #FIXME make revocate   in crl
 
     StorePref=${container_type}_${parent_engine}
     rm /home/certs/store/public/certs/${StorePref}_${cert_name}.crt
     rm /home/certs/store/public/keys/${StorePref}_${cert_name}.key

 
echo "Success"
exit 0

