#!/bin/bash
echo -n '{"certs":['
n=0

for service in `ls /home/certs/store/services/`
 do
 if test -f /home/certs/store/services/$service/certs/default.crt
  then
    domain=`cat /home/certs/store/services/$service/certs/default.crt \
    | openssl x509 -noout -subject |sed "/^.*CN=/s///" | sed "/\*/s///" `
 elif test -f /home/certs/store/services/$service/certs/engines.crt
  then
   domain=`cat /home/certs/store/services/$service/certs/engines.crt \
   | openssl x509 -noout -subject |sed "/^.*CN=/s///"| sed "/\*/s///"`
   else   
    domain=`cat /home/certs/store/services/$service/certs/*.crt \
   | openssl x509 -noout -subject |sed "/^.*CN=/s///"| sed "/\*/s///"`
 fi

 if test $n = 1
   then
    echo -n ,
 fi
  
 echo -n '{"service_name":"'$service'","cert_name":"'$domain'"}'
 n=1
done

echo -n ']}'