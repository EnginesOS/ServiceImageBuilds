#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="fqdn cert_type"
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

if ! test -f /home/certs/store/$cert_type/certs/$store/${fqdn}.crt 
 then
   echo "No such cert  $store/$fqdn"
   exit 
fi


sudo -n /home/engines/scripts/engine/_remove_cert.sh $cert_type/certs/$store/${fqdn}.crt 
if test $? -ne 0
 then
   echo "Failed to Delete Cert $fqdn"
   exit 127
fi
    
sudo -n /home/engines/scripts/engine/_remove_cert.sh $cert_type/keys/$store/${fqdn}.key
if test $? -ne 0
 then
  echo "Failed to Delete Key $fqdn"
  exit 127
fi
    

exit 0
 	
