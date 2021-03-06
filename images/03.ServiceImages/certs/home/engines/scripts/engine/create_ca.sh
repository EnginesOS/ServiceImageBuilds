#!/bin/sh

 . /home/engines/scripts/engine/cert_dirs.sh

if test -f $StoreRoot/private/ca/keys/${ca_name}_CA.key
	then	
		echo '{"status":"Error","message":"CA '$ca_name' Exists"}'
		exit 2
 #cp $StoreRoot/public/ca/certs/$ca_name.pem  $StoreRoot/public/ca/certs/$ca_name.pem.bak

 #cp $StoreRoot/private/ca/keys/$ca_name.key  $StoreRoot/private/ca/keys/$ca_name.key.bak

fi

mkdir -p $StoreRoot/$ca_name/

if ! test -f $StoreRoot/$ca_name/index.txt
 then
  touch $StoreRoot/$ca_name/index.txt
  echo 9999 > $StoreRoot/$ca_name/crlnumber
  touch $StoreRoot/$ca_name/index.txt.attr
fi  
echo "cert_type=$cert_type 
	owner_type=$container_type
	owner=$parent_engine
	ca_name=$ca_name " > $StoreRoot/$ca_name/${ca_name}.meta
	
load_cert_defaults

echo $country >/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo $state >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo $city >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo $person >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo $organisation >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup


echo $domain_name CA  >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo "" >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
echo "" >>/home/engines/scripts/configurators/saved/$ca_name.ca_setup
#cat /home/engines/scripts/configurators/saved/$ca_name.ca_setup

mkdir -p $StoreRoot/private/$ca_name $StoreRoot/$ca_name
 
cat /home/engines/templates/openssl.cnf \
	| sed "/CA_NAME/s//$ca_name/g" > /$StoreRoot/private/$ca_name/open_ssl.cnf
 
openssl genrsa -out $StoreRoot/private/$ca_name/${ca_name}_CA.key 2048 
if ! test -f $StoreRoot/private/$ca_name/${ca_name}_CA.key
 then
  echo '{"status":"error","message":"Failed to create key '$StoreRoot/private/$ca_name/${ca_name}_CA.key'" }'
  exit 3
fi  
openssl req \
		-x509 \
		-new \
		-nodes \
		-key $StoreRoot/private/$ca_name/${ca_name}_CA.key\
		-days 1024 \
		-sha256 \
		-out $StoreRoot/public/ca/certs/${ca_name}_CA.pem \
		< /home/engines/scripts/configurators/saved/$ca_name.ca_setup
if ! test -f $StoreRoot/public/ca/certs/${ca_name}_CA.pem
 then
  echo '{"status":"error","message":"Failed to create CA certificate '$StoreRoot/public/ca/certs/${ca_name}_CA.pem'" }'
  exit 3
fi  

/home/engines/scripts/engine/build_crl.sh ${ca_name}

chmod og-r $StoreRoot/private/$ca_name/${ca_name}_CA.key     
echo '{"status":"success"}'
exit 0
        