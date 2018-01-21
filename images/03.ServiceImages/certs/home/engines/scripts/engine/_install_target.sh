#!/bin/bash
#_install_target.sh ${install_target} $cert_type $cert_name ${dest_cert_name}`

install_target=$1
cert_type=$2
cert_name=$3
dest_cert_name=$4

ctype=`echo $1 |cu -f1 -d/`
cname=`echo $1 |cu -f2 -d/`

TOP_LEVEL=/home/certs/store

if test $ctype = service
 then
   id=`grep _$service /home/engines/system/service_uids | awk '{print $3}'`
elif test $ctype = app   
 then
   id=22671
elif test $ctype = system
 then
   id=21000
else
 echo unknown ctype
 exit 127
fi


function install_cert {

mkdir -p TOP_LEVEL/${install_target}/certs/
mkdir -p $TOP_LEVEL/${install_target}/keys/

cp $TOP_LEVEL/$cert_type/certs/${cert_name}.crt $TOP_LEVEL/${install_target}/certs/${dest_name}.crt 
cp $TOP_LEVEL/$cert_type/keys/${cert_name}.key $TOP_LEVEL/${install_target}/keys/${dest_name}.key
chown $id $TOP_LEVEL/${install_target}/keys/${dest_name}.key $TOP_LEVEL/${install_target}/certs/${dest_name}.crt 
chmod og-rw $TOP_LEVEL/${install_target}/keys/${dest_name}.key 
chmod og-w $TOP_LEVEL/${install_target}/certs/${dest_name}.crt
echo $store_name > $TOP_LEVEL/${install_target}/certs/store
}

install_cert



