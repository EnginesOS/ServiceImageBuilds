#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z ${cert_name}
 then
  echo Missing cert_name
  exit 255
fi

if test -z ${store}
 then
  echo Missing store
  exit 255
fi

if ! test -f /home/certs/store/public/certs/$store/${cert_name}.crt 
 then
 	 echo "Missing  $store/$cert_name"
       exit 255
    fi


   sudo -n /home/remove.sh certs/$store/${cert_name}.crt 
   
     if test $? -ne 0
     then
       echo "Failed to Delete Cert $cert_name"
       exit 255
    fi
    
   sudo -n /home/remove.sh keys/$store/${cert_name}.key
   
     if test $? -ne 0
     then
       echo "Failed to Delete Key $cert_name"
       exit 255
    fi


exit 0
 	
