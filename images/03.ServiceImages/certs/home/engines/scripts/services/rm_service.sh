#!/bin/sh
#. /home/engines/functions/params_to_env.sh
#params_to_env
 . /home/engines/functions/checks.sh
 
required_values="container_type parent_engine common_name ca_name"
check_required_values

cert_type=generated
 . /home/engines/scripts/engine/cert_dirs.sh
 resolve_key_dir
 resolve_cert_dir


if ! test -z $install_target
 then
  deploy_name=$install_target
else
    deploy_name=${common_name}
fi    

if ! test -f $cert_dir/${common_name}.crt 
 then
 	 echo "Missing Cert $cert_dir/${common_name}.crt"
     exit 126
fi

#domain_name=`cat $cert_dir/${common_name}.crt  | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*\./s///"`

sudo -n /home/engines/scripts/engine/sudo/_remove_cert.sh $cert_dir/${common_name}.crt 
   
if test $? -ne 0
 then
  echo "Failed to Delete Cert $cert_dir/${common_name}.crt"
  exit 127
fi
    
 sudo -n /home/engines/scripts/engine/sudo/_remove_cert.sh $key_dir/${common_name}.key
if test $? -ne 0
 then
  echo "Failed to Delete Key $key_dir/${common_name}.key"
  exit 125
fi
    
if test -f /home/certs/store/services/wap/certs/${common_name}.crt
 then
  sudo -n /home/engines/scripts/engine/sudo/_remove_cert.sh service wap/certs/${common_name}.crt
  sudo -n /home/engines/scripts/engine/sudo/_remove_cert.sh service wap/keys/${common_name}.key
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