#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="container_type parent_engine common_name"
check_required_values

store=${container_type}s/${parent_engine}/

if ! test -z $install_target
 then
  deploy_name=$install_target
else
    deploy_name=${common_name}
fi    

if ! test -f /home/certs/store/generated/certs/$store/${common_name}.crt 
 then
 	 echo "Missing Cert  /home/certs/store/generated/certs/$store/${common_name}.crt"
     exit 126
fi

#domain_name=`cat /home/certs/store/generated/certs/$store/${common_name}.crt  | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*\./s///"`

sudo -n /home/engines/scripts/engine/_remove_cert.sh certs/$store/${common_name}.crt 
   
if test $? -ne 0
 then
  echo "Failed to Delete Cert certs/$store/${common_name}.crt"
  exit 127
fi
    
 sudo -n /home/engines/scripts/engine/_remove_cert.sh keys/$store/${common_name}.key
if test $? -ne 0
 then
  echo "Failed to Delete Key keys/$store/${common_name}.key"
  exit 125
fi
    
if test -f /home/certs/store/services/wap/certs/${common_name}.crt
 then
  sudo -n /home/engines/scripts/engine/_remove_cert.sh service wap/certs/${common_name}.crt
  sudo -n /home/engines/scripts/engine/_remove_cert.sh service wap/keys/${common_name}.key
fi

 	
if ! test -f /home/certs/store/live/${container_type}s/$store/certs/${deploy_name}.crt
   then
    rm  /home/certs/store/live/${container_type}s/$store/certs/${deploy_name}.crt
  if test $? -ne 0
   then
    echo "Failed to Delete cert /home/certs/store/live/${container_type}s/$store/certs/${deploy_name}.crt"
    exit 124
  fi

 rm  /home/certs/store/live/${container_type}s/$store/keys/${deploy_name}.key
 if test $? -ne 0
 then
  echo "Failed to Delete Key /home/certs/store/live/${container_type}s/$store/keys/${deploy_name}.key"
  exit 123
 fi
fi

exit 0