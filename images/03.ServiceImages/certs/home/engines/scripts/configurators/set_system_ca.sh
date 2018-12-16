#!/bin/sh
 . /home/engines/functions/checks.sh
sudo -n /home/engines/scripts/engine/_fix_perms.sh

if test -f /home/certs/store/private/ca/keys/system_CA.key
	then	
		echo "CA Exists"
		exit 127
 cp /home/certs/store/public/ca/certs/system_CA.pem  /home/certs/store/public/ca/certs/system_CA.pem.bak

 cp /home/certs/store/private/ca/keys/system_CA.key  /home/certs/store/private/ca/keys/system_CA.key.bak

fi




required_values="domain_name country state city organisation person"
check_required_values

CERT_DEFAULTS_FILE=/home/certs/store/default_cert_details
echo country=\"$country\" > $CERT_DEFAULTS_FILE
echo state=\"$state\" >> $CERT_DEFAULTS_FILE
echo organisation=\"$organisation\" >> $CERT_DEFAULTS_FILE
echo city=\"$city\" >> $CERT_DEFAULTS_FILE
echo person=\"$person\" >> $CERT_DEFAULTS_FILE
 
cp /home/engines/scripts/configurators/saved/ca_setup /home/engines/scripts/configurators/saved/ca_params


echo country=\"$country\" >/home/engines/scripts/configurators/saved/ca_saved
echo  state=\"$state\" >>/home/engines/scripts/configurators/saved/ca_saved
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
mkdir -p /home/certs/store/public/ca/keys/
mkdir -p /home/certs/store/public/ca/certs
mkdir -p /home/certs/store/private/ca/keys/
chmod og-rwx  /home/certs/store/private/ca/keys/
 
openssl genrsa -out /home/certs/store/private/ca/keys/system_CA.key 2048
openssl req -x509 -new -nodes -key /home/certs/store/private/ca/keys/system_CA.key -days 1024 -sha256 -out /home/certs/store/public/ca/certs/system_CA.pem < /home/engines/scripts/configurators/saved/ca_setup
        
chmod og-r /home/certs/store/private/ca/keys/system_CA.key        
        