#!/bin/sh
 . /home/engines/functions/checks.sh

required_values="certificate"
check_required_values

. /home/engines/scripts/engine/cert_dirs.sh

mkdir -p $StoreRoot/external_ca/certs/
echo $certificate > $StoreRoot/external_ca/certs/tmp.crt


common_name=`cat $StoreRoot/external_ca/certs/tmp.crt | openssl x509 -noout -subject  |sed "/^.*CN.*=/s///"| sed "/\*\./s///"`

if test -z ${common_name}
 then
  echo Missing common_name
  rm $StoreRoot/external_ca/certs/tmp.crt
  exit 127
fi

if ! $pending_csr_dir/${common_name}.csr
 then 
  echo "No Matching CSR"
  echo "You have the private key then you should imported the certificate"
  exit 1
 fi 


mv $pending_csr_dir/${common_name}.csr $StoreRoot/external_ca/certs/

mv $StoreRoot/external_ca/certs/tmp.crt $StoreRoot/external_ca/certs/${common_name}.crt

store=external_ca
export cert_name store install_target

if ! test -z ${install_target}
 then
   if $install_target=default
    then
     /home/engines/scripts/engine/set_default.sh all external_ca ${common_name}
    else      
     sudo -n /home/engines/scripts/engine/_install_target.sh ${install_target} external_ca ${common_name} ${common_name}
   fi  
fi
 