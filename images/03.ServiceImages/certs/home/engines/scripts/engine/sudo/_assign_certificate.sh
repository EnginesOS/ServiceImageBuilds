#!/bin/bash


echo _assign_certificate.sh $*  >>/tmp/install_called


#need 
#ca_name 
#destination_name  
#install_target (format ctype/cname )
#cert_name
ca_name=$1
cert_name=$2
install_target=$3
destination_name=$4



. /home/engines/scripts/engine/cert_dirs.sh
resolve_cert_dir
resolve_key_dir



if test "$destination_name" = default
 then
  /home/engines/scripts/engine/set_default.sh ${ca_name} ${cert_name} $install_target 
  exit
fi

function set_uid {

 ctype=`echo $install_target |cut -f1 -d/`
 cname=`echo $install_target |cut -f2 -d/`
  
  if test $ctype = services 
   then
   	service=`basename ${install_target}`
     if test -f /home/engines/etc/containers/services/$service/uid
      then
     	  id=`cat /home/engines/etc/containers/services/$service/uid`
     else
     	  id=`grep _$service /home/engines/system/service_uids | awk '{print $3}'`
     fi		
  elif test $ctype = apps
   then
   	engine=`basename ${install_target}`
   	  if test -f  /home/engines/etc/containers/apps/${engine}/uid
   	   then 
   	    id=`cat /home/engines/etc/containers/apps/${engine}/uid`
   	    else
          id=`grep `cat /home/engines/etc/containers/apps/${engine}/frame_work` /home/engines/system/framework_user_uids |awk '{print $3}'`
      fi    
  elif test $ctype = system_services
   then
     id=21000
  else
   echo unknown ctype $ctype
   exit 0
  fi
}

function install_cert {
 mkdir -p `dirname $InstalledRoot/${install_target}/certs/${destination_name}`
 mkdir -p `dirname $InstalledRoot/${install_target}/keys/${destination_name}`

 cp $cert_dir/${cert_name}.crt $InstalledRoot/${install_target}/certs/${destination_name}.crt 
 cp $key_dir/${cert_name}.key $InstalledRoot/${install_target}/keys/${destination_name}.key
 cp $cert_dir/${cert_name}.meta $InstalledRoot/${install_target}/certs/${destination_name}.meta
 chown $id $InstalledRoot/${install_target}/keys/${destination_name}.key $InstalledRoot/${install_target}/certs/${destination_name}.crt 
 chmod og-rw $InstalledRoot/${install_target}/keys/${destination_name}.key 
 chmod og-w $InstalledRoot/${install_target}/certs/${destination_name}.crt
}

set_uid
install_cert
