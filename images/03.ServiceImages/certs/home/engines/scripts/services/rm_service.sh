#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="cert_name container_type parent_engine domain_name"
check_required_values

store=${container_type}s/${parent_engine}/

if ! test -f /home/certs/store/public/certs/$store/${cert_name}.crt 
 then
 	 echo "Missing Cert $store/$cert_name"
     exit 127
fi

domain_name=`cat /home/certs/store/public/certs/$store/${cert_name}.crt  | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*/s///"`

sudo -n /home/engines/scripts/engines/_remove.sh certs/$store/${cert_name}.crt 
   
if test $? -ne 0
 then
  echo "Failed to Delete Cert $cert_name"
  exit 127
fi
    
 sudo -n /home/engines/scripts/engines/_remove.sh keys/$store/${cert_name}.key
if test $? -ne 0
 then
  echo "Failed to Delete Key $cert_name"
  exit 127
fi
    
if test -f /home/certs/store/services/wap/certs/${domain_name}.crt
 then
  sudo -n /home/engines/scripts/engines/_remove.sh service wap/certs/${domain_name}.crt
  sudo -n /home/engines/scripts/engines/_remove.sh service wap/keys/${domain_name}.key
fi
exit 0
 	

