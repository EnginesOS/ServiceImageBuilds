#!/bin/bash

function gen_service_key {

echo addprinc -randkey $prefix/$parent_engine.engines.internal@ENGINES.INTERNAL | kadmin.local
r=$?

  
 if test $r -ne 0
  then
   echo "Failed to create principle  $prefix/$parent_engine.engines.internal"
 else 
  mkdir -p /etc/krb5kdc/${container_type}s/$parent_engine 
  echo ktadd -k /etc/krb5kdc/${container_type}s/$parent_engine/$key_filename $prefix/$parent_engine.engines.internal@ENGINES.INTERNAL | kadmin.local
  r=$?
   if test $r -ne 0
  then
   echo "Failed to create principle  $prefix/$parent_engine.engines.internal"
  fi  
 fi  
 if ! test -z $owner
  then
   if test ${container_type} = app
    then
     if test -f /home/engines/etc/containers/${container_type}s/$parent_engine/uid
       then
        uid=`cat /home/engines/etc/containers/${container_type}s/$parent_engine/uid`
     else
       fw=`cat /home/engines/etc/containers/${container_type}s/$parent_engine/frame_work`
       uid=`grep ${fw} /home/engines/system/framework_user_uids |awk '{print $3}' | head -1`        
     fi
   else
    uid=`cat /home/engines/etc/containers/${container_type}s/$parent_engine/uid`
   fi
else
  uid=$owner
fi

if test -z $uid
 then
  uid=0
fi
    
chown $uid /etc/krb5kdc/${container_type}s/$parent_engine/$key_filename
  
}

if test -z $prefix
 then
  prefix=host
fi  
  
if test $prefix = host
 then
  key_filename=${parent_engine}.keytab
 else
  key_filename=${prefix}_${parent_engine}.keytab
fi
  
gen_service_key

exit $r
