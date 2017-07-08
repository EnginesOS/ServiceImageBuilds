#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env



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

domain_name=`cat /home/certs/store/public/certs/imported/tmp.crt | openssl x509 -noout -subject  |sed "/^.*CN=/s///"`

if test -z ${domain_name}
 then
  echo Missing domain_name
  rm /home/certs/store/public/keys/imported/tmp.key /home/certs/store/public/certs/imported/tmp.crt
  exit 255
fi

mv /home/certs/store/public/keys/imported/tmp.key /home/certs/store/public/keys/imported/${domain_name}.key
mv /home/certs/store/public/certs/imported/tmp.crt /home/certs/store/public/certs/imported/${domain_name}.crt
 
if ! test -z ${install_target}
 then
  sudo -n /home/install_target.sh ${install_target} imported/${domain_name} ${domain_name}
fi
 
 exit 0