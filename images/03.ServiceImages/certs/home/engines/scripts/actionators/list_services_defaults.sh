#!/bin/bash
function get_alt_names 
{
names=`cat /home/certs/store/live/services/$service/certs/$service.crt \
       | openssl x509 -text |grep DNS: | sed "s/DNS://g" | sed "s/,/ /g" `
       an=0
       alt_names='{"alt_names":'
       for name in names
        do
         if test $an -eq 0
          then
            alt_names=$alt_names"["
           an=1
          else
            alt_names=$alt_names","
          fi
          alt_names=$alt_names'"'$name"'            
        done
        if test $an -eq 1
          then
            alt_names=$alt_names"]"
          else
              alt_names='""'
         fi 
}
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
    get_alt_names
   echo -n '{"service_name":"'$service'","CN":"'$domain'","alt_names":'$alt_names',"store":'$store'}'
   n=1
 fi
done

echo -n ']}'
