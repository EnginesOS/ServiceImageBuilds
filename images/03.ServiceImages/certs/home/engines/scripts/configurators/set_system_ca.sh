#!/bin/sh
 . /home/engines/functions/checks.sh

ca_name=system
export ca_name

required_values="domain_name country state city organisation person "
check_required_values


 . /home/engines/scripts/engine/cert_dirs.sh
 

echo _country=\"$country\" > $CERT_DEFAULTS_FILE
echo _state=\"$state\" >> $CERT_DEFAULTS_FILE
echo _organisation=\"$organisation\" >> $CERT_DEFAULTS_FILE
echo _city=\"$city\" >> $CERT_DEFAULTS_FILE
echo _person=\"$person\" >> $CERT_DEFAULTS_FILE
 
cp $CERT_DEFAULTS_FILE /home/engines/scripts/configurators/saved/ca_params
 
 sudo -n /home/engines/scripts/engine/sudo/_fix_perms.sh

mkdir -p $StoreRoot/public/ca/keys/
mkdir -p $StoreRoot/public/ca/certs
mkdir -p $StoreRoot/private/ca/keys/
chmod og-rwx  $StoreRoot/private/ca/keys/

/home/engines/scripts/engine/create_ca.sh


cp /home/engines/scripts/configurators/saved/$ca_name.ca_setup /home/engines/scripts/configurators/saved/cn_defaults

