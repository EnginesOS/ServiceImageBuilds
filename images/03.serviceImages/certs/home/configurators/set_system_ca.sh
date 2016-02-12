#!/bin/bash

service_hash=$1

if test -f /home/certs/store/private/ca/keys/system_CA.key
	then	
		echo "CA Exists"
		exit 127
	fi

echo $1 >/home/configurators/saved/ca_setup
echo $1 >/home/configurators/saved/ca_params



 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env


echo $country >/home/configurators/saved/ca_setup
echo $state >>/home/configurators/saved/ca_setup
echo $city >>/home/configurators/saved/ca_setup
echo $person >>/home/configurators/saved/ca_setup
echo $organisation >>/home/configurators/saved/ca_setup
echo $domainname CA  >>/home/configurators/saved/ca_setup
echo "" >>/home/configurators/saved/ca_setup
echo "" >>/home/configurators/saved/ca_setup
mkdir -p /home/certs/store/public/ca/keys/
mkdir -p /home/certs/store/public/ca/certs
mkdir -p /home/certs/store/private/ca/keys/
chmod og-rwx  /home/certs/store/private/ca/keys/


        openssl genrsa -out /home/certs/store/private/ca/keys/system_CA.key 2048
        openssl req -x509 -new -nodes -key /home/certs/store/private/ca/keys/system_CA.key -days 1024 -out /home/certs/store/public/ca/certs/system_CA.pem < /home/configurators/saved/ca_setup
        
        