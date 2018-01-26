#!/bin/bash

function find_certs 
{
n=0
if ! test -d /home/certs/store/live/$consumer_type_path/
 then
   echo '""' 
else
  echo '['
  for consumer in `ls /home/certs/store/live/$consumer_type_path/`
   do
    certs=`find /home/certs/store/live/$consumer_type_path/$consumer/certs/ -name "*.crt" |sed "s/\.crt//"`
   for cert_name in $certs 
     do
       cert_name=`basename $cert_name`
       domain=`cat /home/certs/store/live/$consumer_type_path/$consumer/certs/$cert_name.crt \
       | openssl x509 -noout -subject |sed "/^.*CN=/s///" | sed "/\*/s///" `
    
      if test $n -eq 1
        then
         echo -n ,
      fi
     if test -f /home/certs/store/live/$consumer_type_path/${consumer}/certs/store.$cert_name
      then
      	store=`cat /home/certs/store/live/$consumer_type_path/${consumer}/certs/store.$cert_name`
      	else 
      	 store='""'
      fi
       if test $consumer = $cert_name
        then
         default=true
        else
         default=false
       fi   
       consumer_type=`echo $consumer_type_path | sed "s/s$//"`
     echo -n '{"consumer":"'$consumer'","consumer_type":"'$consumer_type'","cert_name":"'$domain'","store":'$store',"default":"'$default'"}'
     n=1
   done
  done
  echo ']'
fi
}
function apps_certs 
{
echo '"services":'
consumer_type_path=services
find_certs
}

function services_certs
{
echo '"apps":'
consumer_type_path=apps
find_certs

}

echo -n '{"deployed_certs":{'
echo '"services":'
services_certs
echo ',"apps":'
apps_certs
echo '}}'


