#!/bin/bash

function gen_service_key {
echo addprinc -randkey host/$parent_engine.engines.internal@ENGINES.INTERNAL | kadmin.local
r=$?
 if test $r -ne 0
  then
   echo "Failed to create principle  host/$parent_engine.engines.internal"
 else 
  mkdir -p /etc/krb5kdc//${container_type}s/$parent_engine 
  echo ktadd -k /etc/krb5kdc/${container_type}s/$parent_engine/$parent_engine.keytab host/$parent_engine.engines.internal@ENGINES.INTERNAL | kadmin.local
  r=$?
   if test $r -ne 0
  then
   echo "Failed to create principle  host/$parent_engine.engines.internal"
  fi  
 fi  
}
gen_service_key

if test $r -eq 0 
 then
  echo "Success"
fi

exit $r
