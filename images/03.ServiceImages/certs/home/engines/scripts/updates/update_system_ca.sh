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

cp ca/keys/system_CA.key system/

cat /home/engines/templates/openssl.cnf | sed "/CA_NAME/s//system/g" >  system/open_ssl.cnf
 touch /home/certs/store/system/index.txt
 echo 9992 > /home/certs/store/system/crlnumber
 touch /home/certs/store/system/index.txt.attr
 touch /home/certs/store/.rnd
 
/home/engines/scripts/engine/build_crl.sh system
 if test $? -eq 0
  then
   touch /home/engines/scripts/updates/have_run/$script_name
   exit 0   
 fi
 
touch /home/engines/scripts/updates/had_problem/$script_name

cd /home/certs/store
store_files=`find . -name "store*"`
for file in $store_files
 do 
	ca_name=`cat $file |cut -f4 -d\"`
	cert_name=`cat $file |cut -f8 -d\"`
	file_name=`basename $file | cut -f1 -d.`
	store_dir=`dirname $file`
	echo "ca_name=$ca_name
		  cert_name=$cert_name " > $store_dir/$file_name.meta
done




 