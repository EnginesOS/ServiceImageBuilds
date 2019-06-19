#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
 . /home/engines/functions/checks.sh
required_values=" ca_name"
check_required_values

for type in `ls $StoreRoot/$ca_name/ |egrep -v "csr|setup"`
do
	echo Cert $type
	  for cert in `ls  $StoreRoot/$ca_name/$type | sed "/.pem/s///"`
	    do
	    	echo Cert Common Name $cert
	    done
done