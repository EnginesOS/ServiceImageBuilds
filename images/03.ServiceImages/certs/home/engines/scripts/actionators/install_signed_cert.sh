#!/bin/sh
 . /home/engines/functions/checks.sh

required_values="certificate"
check_required_values

ca_name=external_ca
. /home/engines/scripts/engine/cert_dirs.sh

resolve_cert_dir

mkdir -p $cert_dir
echo "$certificate" > $cert_dir/tmp.crt


common_name=`cat $cert_dir/tmp.crt | openssl x509 -noout -subject  |sed "/^.*CN.*=/s///"| sed "/\*\./s///" | sed s"/[ ]//"`

if test -z ${common_name}
 then
  echo Missing common_name
  rm $cert_dir/tmp.crt
  exit 127
fi

if ! test -f $pending_csr_dir/${common_name}.csr
 then 
  echo "No Matching CSR"
  echo "You have the private key then you should imported the certificate"
  exit 1
 fi 


cp $pending_csr_dir/${common_name}.csr $cert_dir
mkdir $cert_dir/completed_csr
mv $pending_csr_dir/${common_name}.csr $cert_dir/completed_csr
mv $cert_dir/tmp.crt $cert_dir/${common_name}.crt


export cert_name store install_target ca_name

if ! test -z ${install_target}
 then
   if $install_target=default
    then
     /home/engines/scripts/engine/set_default.sh all external_ca ${common_name}
    else      
     sudo -n /home/engines/scripts/engine/sudo/_install_target.sh ${install_target} external_ca ${common_name} ${common_name}
   fi  
fi
 