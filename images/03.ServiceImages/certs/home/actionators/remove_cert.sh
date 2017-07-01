#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z ${cert_name}
 then
  echo Missing cert_name
  exit 255
fi

if test -f /home/certs/store/public/certs/imported/${cert_name}.crt
 then
 	rm /home/certs/store/public/certs/imported/${cert_name}.crt
 
 	if test -f /home/certs/store/public/keys/imported/${cert_name}.key
      then
 	    rm /home/certs/store/public/keys/imported/${cert_name}.key
    else
 	   echo "No Such key ${cert_name}.key"
 	   exit 255
    fi
    exit 0
fi
    cd /home/certs/store/public/certs
 	cert=`find . -name ${cert_name}.crt  `

    if test $? -ne 0
     then
       echo "No such Certificate $cert"
       exit 255
    fi
     sudo -n /home/remove.sh certs/$certs
     if test $? -ne 0
     then
       echo "Failed to Delete Certificate $cert"
       exit 255
    fi
        
    cd /home/certs/store/public/keys
 	key=`find . -name ${cert_name}.key  `

    if test $? -ne 0
     then
       echo "No such Key $key"
       exit 255
    fi
   sudo -n /home/remove.sh keys/$key
     if test $? -ne 0
     then
       echo "Failed to Delete Key $key"
       exit 255
    fi

echo true
exit
 	
