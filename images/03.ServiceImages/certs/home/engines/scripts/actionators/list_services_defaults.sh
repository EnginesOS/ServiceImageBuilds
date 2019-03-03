#!/bin/sh
 . /home/engines/functions/checks.sh
 . /home/engines/scripts/engine/cert_dirs.sh
 
get_alt_names() 
{
names=`cat $InstalledRoot/services/$service/certs/$service.crt \
       | openssl x509 -text |grep DNS: | sed "s/DNS://g" | sed "s/,/ /g" `
       an=0
       for name in $names
        do
         if test $an -eq 0
          then
            alt_names="["
           an=1
          else
            alt_names=$alt_names","
          fi
          alt_names=$alt_names'"'$name'"'          
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

for service in `ls $InstalledRoot/services/`
 do
 if test -f $InstalledRoot/services/$service/certs/$service.crt
  then
    common_name=`cat $InstalledRoot/services/$service/certs/$service.crt \
    | openssl x509 -noout -subject |sed "/^.*CN=/s///"  `
  
  
   if test $n = 1
     then
      echo -n ,
   fi
   if test -f $InstalledRoot/services/${service}/certs/store.$service
    then
    	store=`cat $InstalledRoot/services/${service}/certs/store.$service`
    	else 
    	 store='""'
    fi
    get_alt_names
   echo -n '{"service_name":"'$service'","CN":"'$common_name'","alt_names":'$alt_names',"store":'$store'}'
   n=1
 fi
done

echo -n ']}'
