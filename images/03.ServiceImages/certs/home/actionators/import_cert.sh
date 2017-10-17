#!/bin/bash

. /home/engines/functions/params_to_env.sh
params_to_env



if test -z "${certificate}"
 then
  echo Missing certificate
  exit 255
fi
if test -z "${private_key}"
 then
  echo Missing key
  exit 255
fi

mkdir -p /home/certs/store/public/certs/imported /home/certs/store/public/keys/imported

echo ${private_key} | sed "/\\\n/s//\n/g"  | sed "/\\\r/s///g" > /home/certs/store/public/keys/imported/tmp.key
echo ${certificate}| sed "/\\\n/s//\n/g"  | sed  "/\\\r/s///g" > /home/certs/store/public/certs/imported/tmp.crt

if ! test -z $password
 then
  openssl rsa -in /home/certs/store/public/keys/imported/tmp.key -out /home/certs/store/public/keys/imported/btmp.key -passin pass:${password}
  mv /home/certs/store/public/keys/imported/btmp.key /home/certs/store/public/keys/imported/tmp.key
fi
 

domain_name=`cat /home/certs/store/public/certs/imported/tmp.crt | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*/s///"`

if test -z ${domain_name}
 then
  echo Missing domain_name
  rm /home/certs/store/public/keys/imported/tmp.key /home/certs/store/public/certs/imported/tmp.crt
  exit 255
fi

mv /home/certs/store/public/keys/imported/tmp.key /home/certs/store/public/keys/imported/${domain_name}.key
mv /home/certs/store/public/certs/imported/tmp.crt /home/certs/store/public/certs/imported/${domain_name}.crt
 
if ! test -z ${target}
 then
  sudo -n  /home/engines/scripts/backup/_install_target.sh ${target} imported/${domain_name} ${domain_name}
fi
 
 exit 0