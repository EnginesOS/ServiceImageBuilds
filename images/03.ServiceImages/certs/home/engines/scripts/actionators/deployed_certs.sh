#!/bin/bash

function find_certs 
{
echo '['
for user in `ls /home/certs/store/live/$user_type_path/`
 do
  certs=`ls /home/certs/store/live/$user_type_path/$user/certs/*.crt |sed "s/\.crt//"`
 for cert_name in $certs 
   do
     cert_name=`basename $cert_name`
     domain=`cat /home/certs/store/live/$user_type_path/$user/certs/$cert_name.crt \
     | openssl x509 -noout -subject |sed "/^.*CN=/s///" | sed "/\*/s///" `
  
    if test $n = 1
      then
       echo -n ,
    fi
   if test -f /home/certs/store/live/$user_type_path/${user}/certs/store.$cert_name
    then
    	store=`cat /home/certs/store/live/$user_type_path/${user}/certs/store.$cert_name`
    	else 
    	 store='""'
    fi
     if test $user = $cert_name
      then
       default=true
      else
       default=false
     fi   
     user_type=`echo $user_type_path | sed "s/s$//"`
   echo -n '{"user":'$service'","user_type":"'$user_type'","cert_name":"'$domain'","store":'$store',"default":"'$default'"}'
   n=1
 done
done
echo ']'
}
function apps_certs 
{
echo '"services":'
user_type_path=services
find_certs
}

function services_certs
{
echo '"apps":'
user_type_path=apps
find_certs

}

echo -n '{"deployed_certs":{'
echo '"services":'
services_certs
echo ',"apps":'
apps_certs
echo '}}'


