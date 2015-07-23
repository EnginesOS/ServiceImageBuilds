#/bin/sh

service_hash=$1

if test -f /home/certs/store/ca/keys/system_CA.key
	then	
		echo "CA Exists"
		exit 127
	fi

echo $1 >/home/configurators/saved/ca_setup

. /home/engines/scripts/functions.sh

load_service_hash_to_environment


echo $1 |grep = >/dev/null
        if test $? -ne 0
        then
                exit
        fi
echo $country >/home/configurators/saved/ca_setup
echo $state >>/home/configurators/saved/ca_setup
echo $city >>/home/configurators/saved/ca_setup
echo $person >>/home/configurators/saved/ca_setup
echo $organisation >>/home/configurators/saved/ca_setup
echo $domainname CA  >>/home/configurators/saved/ca_setup
echo "" >>/home/configurators/saved/ca_setup
echo "" >>/home/configurators/saved/ca_setup
mkdir /home/certs/store/ca/keys/
mkdir /home/certs/store/ca/certs/
chmod og-rwx /home/certs/store/ca/keys/
        openssl genrsa -out /home/certs/store/ca/keys/system_CA.key 2048
        openssl req -x509 -new -nodes -key /home/certs/store/ca/keys/system_CA.key -days 1024 -out /home/certs/store/ca/certs/system_CA.pem < /home/configurators/saved/ca_setup
        
        