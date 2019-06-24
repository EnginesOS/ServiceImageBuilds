#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
 . /home/engines/functions/checks.sh
required_values=" ca_name"
check_required_values
echo -n '{"certs":['
if ! test -d $StoreRoot/$ca_name
 then
  echo '{"status":"error","message":"no such '$ca_name'"}'
 exit 2
fi
n=0
for cert in `ls  $StoreRoot/$ca_name/certs |grep .crt | sed "/.crt/s///"`
do
   if test $n -ne 0
    then
     echo -n ,
   else  
     n=1
   fi  
   if ! test -f $StoreRoot/$ca_name/certs/$cert.meta
    then
     echo '{"status":"error","message":"Missing meta data for '$ca_name $cert'"}'
     exit 2
   fi  
  . $StoreRoot/$ca_name/certs/$cert.meta
   echo -n '{"common_name":"'$cert'","cert_type":"'$cert_type'","owner_type":"'$owner_type'","owner":"'$owner'"}'
done

echo -n ']}'        
