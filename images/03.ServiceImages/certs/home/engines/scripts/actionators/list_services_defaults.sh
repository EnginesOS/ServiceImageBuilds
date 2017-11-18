#!/bin/bash
echo -n '{"certs":['
n=0

for service in `ls /home/certs/store/services/`
 do
 if test -f /home/certs/store/services/$service/certs/$service.crt
  then
    domain=`cat /home/certs/store/services/$service/certs/$service.crt \
    | openssl x509 -noout -subject |sed "/^.*CN=/s///" | sed "/\*/s///" `
  
   if test $n = 1
     then
      echo -n ,
   fi
   if test -f /home/certs/store/services/${service}/certs/store
    then
    	store_name=`cat /home/certs/store/services/${service}/certs/store`
    fi
   echo -n '{"service_name":"'$service'","cert_name":"'$domain'","store_name":"'$store_name'"}'
   n=1
 fi
done

echo -n ']}'
