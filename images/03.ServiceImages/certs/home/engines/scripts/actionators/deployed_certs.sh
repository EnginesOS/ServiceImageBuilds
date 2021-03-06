#!/bin/sh
. /home/engines/scripts/engine/cert_dirs.sh
get_alt_names()
{
names=`cat $InstalledRoot/$consumer_type_path/$consumer/certs/$cert_name.crt \
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
find_certs()
{
n=0
if ! test -d $InstalledRoot/$consumer_type_path/
 then
   echo '""' 
else
  echo '['
  for consumer in `ls $InstalledRoot/$consumer_type_path/`
   do
    certs=`find $InstalledRoot/$consumer_type_path/$consumer/certs/ -name "*.crt" |sed "s/\.crt//"`
   for cert_name in $certs 
     do
       cert_name=`basename $cert_name`
       common_name=`cat $InstalledRoot/$consumer_type_path/$consumer/certs/$cert_name.crt \
       | openssl x509 -noout -subject |sed "/^.*CN=/s///" `
       get_alt_names
       
      if test $n -eq 1
        then
         echo -n ,
      fi
      if -f $InstalledRoot/$consumer_type_path/${consumer}/certs/store.$cert_name.meta
       then
       . $InstalledRoot/$consumer_type_path/${consumer}/certs/store.$cert_name.meta
      elif test -f $InstalledRoot/$consumer_type_path/${consumer}/certs/store.$cert_name
       then
      	ca_name=`cat $InstalledRoot/$consumer_type_path/${consumer}/certs/store.$cert_name`
      	else 
      	 ca_name='""'
      fi
       if test $consumer = $cert_name
        then
         default=true
        else
         default=false
       fi   
       consumer_type=`echo $consumer_type_path | sed "s/s$//"`
     echo -n '{"consumer":"'$consumer'","consumer_type":"'$consumer_type'","cert_name":"'$cert_name'","CN":"'$common_name'","alt_names":'$alt_names',"ca_name":'$ca_name',"default":"'$default'"}'
     n=1
   done
  done
  echo ']'
fi
}
apps_certs()
{
echo '"services":'
consumer_type_path=services
find_certs
}

services_certs()
{
echo '"apps":'
consumer_type_path=apps
find_certs

}

echo -n '{"deployed_certs":{'
services_certs
echo ,
apps_certs
echo '}}'


