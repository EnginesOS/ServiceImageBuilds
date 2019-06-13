#!/bin/sh
 . /home/engines/functions/checks.sh

 . /home/engines/scripts/engine/cert_dirs.sh
sudo -n /home/engines/scripts/engine/sudo/_fix_perms.sh

if test -f $StoreRoot/private/ca/keys/system_CA.key
	then	
		echo "CA Exists"
		exit 127
 cp $StoreRoot/public/ca/certs/system_CA.pem  $StoreRoot/public/ca/certs/system_CA.pem.bak

 cp $StoreRoot/private/ca/keys/system_CA.key  $StoreRoot/private/ca/keys/system_CA.key.bak

fi

required_values="domain_name country state city organisation person"
check_required_values

CERT_DEFAULTS_FILE=$StoreRoot/default_cert_details
echo country=\"$country\" > $CERT_DEFAULTS_FILE
echo state=\"$state\" >> $CERT_DEFAULTS_FILE
echo organisation=\"$organisation\" >> $CERT_DEFAULTS_FILE
echo city=\"$city\" >> $CERT_DEFAULTS_FILE
echo person=\"$person\" >> $CERT_DEFAULTS_FILE
 
cp $CERT_DEFAULTS_FILE /home/engines/scripts/configurators/saved/ca_params

echo country=\"$country\" >/home/engines/scripts/configurators/saved/ca_saved
echo state=\"$state\" >>/home/engines/scripts/configurators/saved/ca_saved
echo city=\"$city\" >>/home/engines/scripts/configurators/saved/ca_saved
echo person=\"$person\" >>/home/engines/scripts/configurators/saved/ca_saved
echo organisation=\"$organisation\" >>/home/engines/scripts/configurators/saved/ca_saved
echo domain_name=$domain_name  >>/home/engines/scripts/configurators/saved/ca_saved

echo $country >/home/engines/scripts/configurators/saved/ca_setup
echo $state >>/home/engines/scripts/configurators/saved/ca_setup
echo $city >>/home/engines/scripts/configurators/saved/ca_setup
echo $person >>/home/engines/scripts/configurators/saved/ca_setup
echo $organisation >>/home/engines/scripts/configurators/saved/ca_setup
cp /home/engines/scripts/configurators/saved/ca_setup /home/engines/scripts/configurators/saved/cn_defaults
echo $domain_name CA  >>/home/engines/scripts/configurators/saved/ca_setup
echo "" >>/home/engines/scripts/configurators/saved/ca_setup
echo "" >>/home/engines/scripts/configurators/saved/ca_setup
cat /home/engines/scripts/configurators/saved/ca_setup
mkdir -p $StoreRoot/public/ca/keys/
mkdir -p $StoreRoot/public/ca/certs
mkdir -p $StoreRoot/private/ca/keys/
chmod og-rwx  $StoreRoot/private/ca/keys/
 
openssl genrsa -out $StoreRoot/private/ca/keys/system_CA.key 2048
openssl req -x509 -new -nodes -key $StoreRoot/private/ca/keys/system_CA.key -days 1024 -sha256 -out $StoreRoot/public/ca/certs/system_CA.pem < /home/engines/scripts/configurators/saved/ca_setup
        
chmod og-r $StoreRoot/private/ca/keys/system_CA.key        
        