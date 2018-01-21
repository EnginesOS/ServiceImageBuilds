#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="certificate private_key"
check_required_values

mkdir -p /home/certs/store/imported/certs/ /home/certs/store/imported/keys/

if ! test -z $password
 then
  openssl rsa -in /home/certs/store/imported/keys/tmp.key -out /home/certs/store/imported/keys/btmp.key -passin pass:${password}
  mv /home/certs/store/imported/keys/btmp.key /home/certs/store/imported/keys/tmp.key
fi

domain_name=`cat /home/certs/store/imported/certs/tmp.crt | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*/s///"`

if test -z ${domain_name}
 then
  echo Missing domain_name
  rm /home/certs/store/imported/keys/tmp.key /home/certs/store/imported/certs/tmp.crt
  exit 127
fi

mv /home/certs/store/imported/keys/tmp.key /home/certs/store/imported/keys/${domain_name}.key
mv /home/certs/store/imported/certs/tmp.crt /home/certs/store/imported/certs/${domain_name}.crt

store=imported/${domain_name}
export cert_name store target

if ! test -z ${target}
 then
   if $target=default
    then
     /home/engines/scripts/engine/set_default.sh all imported ${domain_name}
    else      
     sudo -n /home/engines/scripts/engine/_install_target.sh ${target} imported ${domain_name} ${domain_name}
   fi  
fi
 
 exit 0