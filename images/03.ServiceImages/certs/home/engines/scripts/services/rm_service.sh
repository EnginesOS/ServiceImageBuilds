#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

if test -z ${cert_name}
 then
  echo Missing cert_name
  exit 255
fi
if test -z ${parent_engine}
 then
  echo Missing parent_engine
  exit 255
fi
if test -z ${container_type}
 then
  echo Missing container_type
  exit 255
fi

store=${container_type}s/${parent_engine}/


if ! test -f /home/certs/store/public/certs/$store/${cert_name}.crt 
 then
 	 echo "Missing  $store/$cert_name"
       exit 255
    fi

domain_name=`cat /home/certs/store/public/certs/$store/${cert_name}.crt  | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*/s///"`

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
    
if test -f /home/certs/store/services/wap/certs/${domain_name}.crt
 then
  sudo -n /home/remove.sh service wap/certs/${domain_name}.crt
  sudo -n /home/remove.sh service wap/keys/${domain_name}.key
fi
exit 0
 	

#
##!/bin/bash
#
#. /home/engines/functions/params_to_env.sh
#params_to_env
#
#if test -z "${cert_name}"
#	then
#		echo Error:Missing cert_name
#        exit -1
#    fi
# 
# #FIXME make revocate   in crl
# 
#     StorePref=${container_type}_${parent_engine}
#     rm /home/certs/store/public/certs/${StorePref}_${cert_name}.crt
#     rm /home/certs/store/public/keys/${StorePref}_${cert_name}.key
#
# 
#echo "Success"
#exit 0
#
