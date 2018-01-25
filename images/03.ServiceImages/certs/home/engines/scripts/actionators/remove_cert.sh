#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="cert_name store cert_type"
check_required_values

if test $cert_type = generated
 then
 echo "Cant remove  system generated certificate"
 exit   
 fi

if test $cert_type = user
 then
  cert_type=generated 
  store=user
fi 

if ! test -f /home/certs/store/$cert_type/certs/$store/${cert_name}.crt 
 then
   echo "No such cert  $store/$cert_name"
   exit 
fi

domain_name=`cat /home/certs/store/$cert_type/certs/$store/${cert_name}.crt | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*/s///"`

sudo -n /home/engines/scripts/engine/_remove_cert.sh certs/$store/${cert_name}.crt 
if test $? -ne 0
 then
   echo "Failed to Delete Cert $cert_name"
   exit 127
fi
    
sudo -n /home/engines/scripts/engine/_remove_cert.sh keys/$store/${cert_name}.key
if test $? -ne 0
 then
  echo "Failed to Delete Key $cert_name"
  exit 127
fi
    
if test -f /home/certs/store/services/wap/certs/${domain_name}.crt
 then
  sudo -n /home/engines/scripts/engine/_remove_cert.sh service wap/certs/${domain_name}.crt
  sudo -n /home/engines/scripts/engine/_remove_cert.sh service wap/keys/${domain_name}.key
fi

exit 0
 	
