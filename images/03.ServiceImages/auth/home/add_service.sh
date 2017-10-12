#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

if test -z $engine
	then
		echo "Error engine not set"
		exit -1
	fi
	
if test -z $service 
	then
	echo "Error service not set"
		exit -1
	fi	
	
function gen_service_key {
echo addprinc -randkey host/$service.engines.internal@ENGINES.INTERNAL | kadmin.local 
mkdir /etc/krb5kdc/$service 
echo ktadd -k /etc/krb5kdc/$service/$service.keytab host/$service.engines.internal@ENGINES.INTERNAL | kadmin.local 
}
gen_service_key
echo "Success"
exit 0
