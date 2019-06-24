#!/bin/sh
script_name=`basename $0`
if test -f /home/engines/scripts/updates/have_run/$script_name
 then
 # echo "update already run"
  exit 0
fi
  
  cd /home/certs/store
  
  mkdir -p system/saved
  
  
cd /home/certs/store/private
mkdir -p system/keys

cp ca/keys/system_CA.key system/keys/
cat /home/engines/templates/openssl.cnf | sed "/CA_NAME/s//system/g" >  system/openssl.cnf
 touch /home/certs/store/system/index.txt
 echo 9992 > /home/certs/store/system/crlnumber
 touch /home/certs/store/system/index.txt.attr
 
/home/engines/scripts/engine/build_crl.sh system
 if test $? -eq 0
  then
   touch /home/engines/scripts/updates/have_run/$script_name
   exit 0   
 fi
 
touch /home/engines/scripts/updates/had_problem/$script_name

 