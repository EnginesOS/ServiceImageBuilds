#!/bin/bash
echo _install_target.sh $*  >>/tmp/install_called
install_target=$1
cert_type=$2
cert_name=$3
destination_name=$4

if test $cert_type = user
 then
  cert_type=generated 
  cert_name=user/$cert_name
fi  

if test $destination_name = default
 then
  /home/engines/scripts/engine/set_default.sh $install_target ${cert_type} ${cert_name} 
  exit
fi

StoreRoot=/home/certs/store
InstalledRoot=/home/certs/store/live

function set_uid {

 ctype=`echo $install_target |cut -f1 -d/`
 cname=`echo $install_target |cut -f2 -d/`
  
  if test $ctype = services 
   then
   	service=`basename ${install_target}`
     if test -f /home/engines/system/containers/services/$service/uid
      then
     	  id=`cat /home/engines/system/containers/services/$service/uid`
     else
     	  id=`grep _$service /home/engines/system/service_uids | awk '{print $3}'`
     fi		
  elif test $ctype = apps
   then
   	engine=`basename ${install_target}`
      id=`grep `cat /home/engines/system/containers/apps/${engine}/frame_work` /home/engines/system/framework_user_uids |awk '{print $3}'`
  elif test $ctype = system_services
   then
     id=21000
  else
   echo unknown ctype $ctype
   exit 127
  fi
}

function install_cert {
 mkdir -p `dirname $InstalledRoot/${install_target}/certs/${destination_name}`
 mkdir -p `dirname $InstalledRoot/${install_target}/keys/${destination_name}`

 cp $StoreRoot/$cert_type/certs/${cert_name}.crt $InstalledRoot/${install_target}/certs/${destination_name}.crt 
 cp $StoreRoot/$cert_type/keys/${cert_name}.key $InstalledRoot/${install_target}/keys/${destination_name}.key

 chown $id $InstalledRoot/${install_target}/keys/${destination_name}.key $InstalledRoot/${install_target}/certs/${destination_name}.crt 
 chmod og-rw $InstalledRoot/${install_target}/keys/${destination_name}.key 
 chmod og-w $InstalledRoot/${install_target}/certs/${destination_name}.crt

 echo '{"cert_type":"'$cert_type'","store_path":"'$cert_name'"}' > $InstalledRoot/${install_target}/certs/`dirname ${destination_name}`/store.`basename ${destination_name}`
}

set_uid
install_cert
