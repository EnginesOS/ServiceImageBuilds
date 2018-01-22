#!/bin/bash
echo _install_target.sh $*

install_target=$1
cert_type=$2
cert_name=$3
dest_cert_name=$4

if test $install_target = default
 then
  /home/engines/scripts/engine/set_default.sh all ${cert_type} ${cert_name} 
 exit
 fi

ctype=`echo $1 |cut -f1 -d/`
cname=`echo $1 |cut -f2 -d/`

StoreRoot=/home/certs/store
InstalledRoot=/home/certs/store/live

if test $ctype = services 
 then
 	$service=`basename ${install_target}`
   id=`grep _$service /home/engines/system/service_uids | awk '{print $3}'`
elif test $ctype = apps
 then
   id=22671
elif test $ctype = system_services
 then
   id=21000
else
 echo unknown ctype $ctype
 exit 127
fi


function install_cert {

mkdir -p $StoreRoot/${install_target}/certs/
mkdir -p $StoreRoot/${install_target}/keys/

cp $StoreRoot/$cert_type/certs/${cert_name}.crt $InstalledRoot/${install_target}/certs/${dest_cert_name}.crt 
cp $StoreRoot/$cert_type/keys/${cert_name}.key $InstalledRoot/${install_target}/keys/${dest_cert_name}.key
chown $id $InstalledRoot/${install_target}/keys/${dest_cert_name}.key $InstalledRoot/${install_target}/certs/${dest_cert_name}.crt 
chmod og-rw $InstalledRoot/${install_target}/keys/${dest_cert_name}.key 
chmod og-w $InstalledRoot/${install_target}/certs/${dest_cert_name}.crt
echo $store_name > $InstalledRoot/${install_target}/certs/store
}

install_cert



