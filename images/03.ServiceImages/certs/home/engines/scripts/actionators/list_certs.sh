#!/bin/sh
 . /home/engines/functions/checks.sh
 . /home/engines/scripts/engine/cert_dirs.sh
 
get_alt_names ()
{
names=`cat $StoreRoot/$cert_type/certs/$store/$cert.crt \
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
i=0
ca_names=`ls $StoreRoot/ca/certs/ |grep CA\.pem`
ca_names="$ca_names external_ca imported"

echo -n '{"certs":['
 for ca_name in $ca_names
  do
  if test -d $StoreRoot/$ca_name/certs/
   then
    cd $StoreRoot/$ca_name/certs/
    certs=`find . -name "*.crt" |grep -v default | sed "/\.crt/s///g"`
      for cert in $certs
       do
      	if test $i -eq 0
      	 then
      		i=1
      	else
      		echo -n ,
      	fi
      	   if ! test -f $StoreRoot/$ca_name/certs/$cert.meta
   			then
   			  echo '{"status":"error","message":"Missing meta data for '$ca_name $cert'"}'
   			  exit 2
 		  fi  
        . $StoreRoot/$ca_name/certs/$cert.meta
      
      	
      	cert=`basename $cert`
      	get_alt_names
      	 common_name=`cat $StoreRoot/$cert_type/certs/$store/$cert.crt \
       | openssl x509 -noout -subject |sed "/^.*CN=/s///" `
        echo -n '{"cert_name":"'$cert'","CN":"'$common_name'","alt_names":'$alt_names',"owner_type":"'${owner_type}'","owner":"'${owner}'","ca_name":"'$ca_name'", "cert_type":"'$cert_type'"}'
      done
  fi
  done
echo -n ']}'  
exit 0