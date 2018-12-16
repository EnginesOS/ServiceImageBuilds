#!/bin/sh
 . /home/engines/functions/checks.sh

required_values="common_name cert_type"
check_required_values

if test $cert_type = generated
 then
 echo "Cant remove system generated certificate"
 exit   
 fi

if test $cert_type = user
 then
  cert_type=generated 
  store=user
fi 

if ! test -f /home/certs/store/$cert_type/certs/$store/${common_name}.crt 
 then
   echo "No such cert  $store/$fqdn"
   exit 
fi


sudo -n /home/engines/scripts/engine/_remove_cert.sh $cert_type/certs/$store/${common_name}.crt 
if test $? -ne 0
 then
   echo "Failed to Delete Cert $common_name"
   exit 127
fi
    
sudo -n /home/engines/scripts/engine/_remove_cert.sh $cert_type/keys/$store/${common_name}.key
if test $? -ne 0
 then
  echo "Failed to Delete Key $common_name"
  exit 127
fi
    

exit 0
 	
