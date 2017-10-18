#!/bin/bash



if test -f /home/certs/store/private/ca/keys/system_CA.key
	then	
	#	echo "CA Exists"
	#	exit 127
 cp /home/certs/store/public/ca/certs/system_CA.pem  /home/certs/store/public/ca/certs/system_CA.pem.bak
 #	rm /home/certs/store/public/ca/certs/system_CA.pem
 cp /home/certs/store/private/ca/keys/system_CA.key  /home/certs/store/private/ca/keys/system_CA.key.bak
 #rm /home/certs/store/private/ca/keys/system_CA.key 
fi


. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/ca_setup
parms_to_file_and_env

cp /home/engines/scripts/configurators/saved/ca_setup /home/engines/scripts/configurators/saved/ca_params


echo $country >/home/engines/scripts/configurators/saved/ca_setup
echo $state >>/home/engines/scripts/configurators/saved/ca_setup
echo $city >>/home/engines/scripts/configurators/saved/ca_setup
echo $person >>/home/engines/scripts/configurators/saved/ca_setup
echo $organisation >>/home/engines/scripts/configurators/saved/ca_setup
cp /home/engines/scripts/configurators/saved/ca_setup /home/engines/scripts/configurators/saved/cn_defaults
echo $domainname CA  >>/home/engines/scripts/configurators/saved/ca_setup
echo "" >>/home/engines/scripts/configurators/saved/ca_setup
echo "" >>/home/engines/scripts/configurators/saved/ca_setup
mkdir -p /home/certs/store/public/ca/keys/
mkdir -p /home/certs/store/public/ca/certs
mkdir -p /home/certs/store/private/ca/keys/
chmod og-rwx  /home/certs/store/private/ca/keys/
 
openssl genrsa -out /home/certs/store/private/ca/keys/system_CA.key 2048
openssl req -x509 -new -nodes -key /home/certs/store/private/ca/keys/system_CA.key -days 1024 -sha256 -out /home/certs/store/public/ca/certs/system_CA.pem < /home/engines/scripts/configurators/saved/ca_setup
        
        