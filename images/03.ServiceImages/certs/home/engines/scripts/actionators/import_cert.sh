#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="certificate private_key"
check_required_values

mkdir -p /home/certs/store/imported/certs/ /home/certs/store/imported/keys/
echo $certificate > /home/certs/store/imported/certs/tmp.crt
echo $private_key >  /home/certs/store/imported/keys/tmp.key


if ! test -z $password
 then
  openssl rsa -in /home/certs/store/imported/keys/tmp.key -out /home/certs/store/imported/keys/btmp.key -passin pass:${password}
  mv /home/certs/store/imported/keys/btmp.key /home/certs/store/imported/keys/tmp.key
fi

common_name=`cat /home/certs/store/imported/certs/tmp.crt | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*\./s///"`

if test -z ${common_name}
 then
  echo Missing common_name
  rm /home/certs/store/imported/keys/tmp.key /home/certs/store/imported/certs/tmp.crt
  exit 127
fi

mv /home/certs/store/imported/keys/tmp.key /home/certs/store/imported/keys/${common_name}.key
mv /home/certs/store/imported/certs/tmp.crt /home/certs/store/imported/certs/${common_name}.crt

store=imported/${common_name}
export cert_name store install_target

if ! test -z ${install_target}
 then
   if $install_target=default
    then
     /home/engines/scripts/engine/set_default.sh all imported ${common_name}
    else      
     sudo -n /home/engines/scripts/engine/_install_target.sh ${install_target} imported ${common_name} ${common_name}
   fi  
fi
 
 exit 0