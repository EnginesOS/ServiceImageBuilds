#!/bin/bash

function gen_service_key {

echo addprinc -randkey host/$parent_engine.engines.internal@ENGINES.INTERNAL | kadmin.local
r=$?

 if test $r -ne 0
  then
   echo "Failed to create principle  host/$parent_engine.engines.internal"
 else 
  mkdir -p /etc/krb5kdc/${container_type}s/$parent_engine 
  echo ktadd -k /etc/krb5kdc/${container_type}s/$parent_engine/$parent_engine.keytab host/$parent_engine.engines.internal@ENGINES.INTERNAL | kadmin.local
  r=$?
   if test $r -ne 0
  then
   echo "Failed to create principle  host/$parent_engine.engines.internal"
  fi  
 fi  
 if ! test -z $owner
  then
   if test ${container_type} = app
    then
      uid=`grep ${1} /opt/engines/etc/exported/framework_user_uids |awk '{print $3}' | head -1`
      chown $uid /etc/krb5kdc/${container_type}s/$parent_engine/$parent_engine.keytab
   fi    
 fi  
}

gen_service_key

exit $r
