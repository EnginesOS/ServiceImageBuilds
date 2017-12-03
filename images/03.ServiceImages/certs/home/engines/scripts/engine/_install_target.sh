#!/bin/bash

install_target=$1
cert_name=$2
domain_name=$3


if test -z $store_name
 then
  store_name=`dirname $2`
fi

function install_cert {
if test -z ${dest_name}
 then 
 	dest_name=engines
fi



mkdir -p /home/certs/store/services/${service}/certs/
mkdir -p /home/certs/store/services/${service}/keys/

cp /home/certs/store/public/certs/${cert_name}.crt /home/certs/store/services/${service}/certs/${dest_name}.crt 
cp /home/certs/store/public/keys/${cert_name}.key /home/certs/store/services/${service}/keys/${dest_name}.key
chown $id /home/certs/store/services/${service}/keys/${dest_name}.key /home/certs/store/services/${service}/certs/${dest_name}.crt 
chmod og-rw /home/certs/store/services/${service}/keys/${dest_name}.key 
chmod og-w /home/certs/store/services/${service}/certs/${dest_name}.crt
echo $store_name > /home/certs/store/services/${service}/certs/store
}
function set_service_uid {
id=`grep _$service /home/engines/system/service_uids | awk '{print $3}'`
}

function install_service {
 if test -z $dest_name
  then
	dest_name=$install_target
  fi	
service=$install_target

if test $service = wap
 then
  if ! test $domain_name=default
   then
     dest_name=${domain_name}
  fi   
fi
set_service_uid
install_cert
}


case $install_target in

default)

  domain_name=default
   for install_target in system smtp ftp email mysql pqsql mgmt wap
    do
      install_service
    done  
  ;;
*)
  set_service_uid
  install_service
  ;;
esac


