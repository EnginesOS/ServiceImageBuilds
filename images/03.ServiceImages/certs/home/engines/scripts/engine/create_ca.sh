#!/bin/sh

 . /home/engines/scripts/engine/cert_dirs.sh

if test -f $StoreRoot/private/ca/keys/${ca_name}_CA.key
	then	
		echo '{"status":"Error","message":"CA '$ca_name' Exists"}'
		exit 127
 #cp $StoreRoot/public/ca/certs/$ca_name.pem  $StoreRoot/public/ca/certs/$ca_name.pem.bak

 #cp $StoreRoot/private/ca/keys/$ca_name.key  $StoreRoot/private/ca/keys/$ca_name.key.bak

fi

. $CERT_DEFAULTS_FILE
if test -z $country
 then
  $country=$_country
fi
if test -z $state
 then
  $country=$_state
fi  
if test -z $city
 then
  $country=$_city
fi
if test -z $person
 then
  $country=$_person
fi
if test -z $organisation
 then
  $organisation=$_organisation
fi

echo $country >/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo $state >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo $city >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo $person >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo $organisation >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup


echo $domain_name CA  >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo "" >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo "" >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
cat /home/engines/scripts/configurators/saved/$ca_name.ca_setup

mkdir -p $StoreRoot/private/$ca_name
 
cat /home/engines/templates/openssl.cnf | sed "/CA_NAME/s//$ca_name" > /$StoreRoot/private/$ca_name/open_ssl.cnf
 
openssl genrsa -out $StoreRoot/private/$ca_name/${ca_name}_CA.key  2048
openssl req -x509 -new -nodes -key $StoreRoot/private/$ca_name/${ca_name}_CA.key  -days 1024 -sha256 -out $StoreRoot/public/ca/certs/${ca_name}_CA.pem < /home/engines/scripts/configurators/saved/$ca_name.ca_setup

openssl ca -gencrl\
		   -keyfile $StoreRoot/private/$ca_name/${ca_name}_CA.key  \
		   -cert /$StoreRoot/public/ca/certs/${ca_name}_CA.pem\
		    -config $StoreRoot/private/$ca_name/open_ssl.cnf
 
chmod og-r $StoreRoot/private/$ca_name/${ca_name}_CA.key     
echo '{"status":"success"}'
exit 0
        