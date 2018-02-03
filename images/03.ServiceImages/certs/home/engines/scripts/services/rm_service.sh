#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="cert_name container_type parent_engine domain_name"
check_required_values

store=${container_type}s/${parent_engine}/

if ! test -f /home/certs/store/generated/certs/$store/${cert_name}.crt 
 then
 	 echo "Missing Cert  /home/certs/store/generated/certs/$store/${cert_name}.crt 
     exit 126
fi

domain_name=`cat /home/certs/store/generated/certs/$store/${cert_name}.crt  | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*\./s///"`

sudo -n /home/engines/scripts/engine/_remove_cert.sh certs/$store/${cert_name}.crt 
   
if test $? -ne 0
 then
  echo "Failed to Delete Cert certs/$store/${cert_name}.crt"
  exit 127
fi
    
 sudo -n /home/engines/scripts/engine/_remove_cert.sh keys/$store/${cert_name}.key
if test $? -ne 0
 then
  echo "Failed to Delete Key keys/$store/${cert_name}.key"
  exit 125
fi
    
if test -f /home/certs/store/services/wap/certs/${domain_name}.crt
 then
  sudo -n /home/engines/scripts/engine/_remove_cert.sh service wap/certs/${domain_name}.crt
  sudo -n /home/engines/scripts/engine/_remove_cert.sh service wap/keys/${domain_name}.key
fi

 	
if ! test -f /home/certs/store/live/{$}s/$store/certs/${cert_name}.crt
   then
    rm  /home/certs/store/live/{$}s/$store/certs/${cert_name}.crt
if test $? -ne 0
 then
  echo "Failed to Delete cert /home/certs/store/live/{$}s/$store/certs/${cert_name}.crt"
  exit 124
fi
    rm  /home/certs/store/live/{$}s/$store/keys/${cert_name}.key
if test $? -ne 0
 then
  echo "Failed to Delete Key /home/certs/store/live/{$}s/$store/keys/${cert_name}.key"
  exit 123
fi
fi

exit 0