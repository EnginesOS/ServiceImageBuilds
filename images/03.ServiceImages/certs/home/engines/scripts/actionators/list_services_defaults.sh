#!/bin/bash
echo -n '{"certs":['
n=0

for service in `ls /home/certs/store/live/services/`
 do
 if test -f /home/certs/store/live/services/$service/certs/$service.crt
  then
    domain=`cat /home/certs/store/live/services/$service/certs/$service.crt \
    | openssl x509 -noout -subject |sed "/^.*CN=/s///" | sed "/\*/s///" `
  
   if test $n = 1
     then
      echo -n ,
   fi
   if test -f /home/certs/store/live/services/${service}/certs/store.$service
    then
    	store=`cat /home/certs/store/live/services/${service}/certs/store.$service`
    	else 
    	 store='""'
    fi
   echo -n '{"service_name":"'$service'","cert_name":"'$domain'","store":'$store'}'
   n=1
 fi
done

echo -n ']}'
