#!/bin/sh

if ! test -f $cert_dir/${common_name}.crt 
 then
   echo '{"status":"error","message":"No Such Cert '$cert_dir/${common_name}.crt'"}'
   exit 2
fi

if ! test $ca_name = external_ca -o $ca_name = imported
 then
   openssl ca -revoke $cert_dir/${common_name}.crt -config $StoreRoot/private/$ca_name/open_ssl.cnf
   openssl ca -gencrl  \
			-config $StoreRoot/private/$ca_name/open_ssl.cnf \
		 	-out $StoreRoot/public/ca/certs/${ca_name}_CRL.pem
		 	cat $StoreRoot/public/ca/certs/${ca_name}_CA.pem \
		 		$StoreRoot/public/ca/certs/${ca_name}_CRL.pem \
		 		> $StoreRoot/public/ca/certs/${ca_name}_CA_CRL.pem 
fi		 	

#sudo -n /home/engines/scripts/engine/sudo/_remove_cert.sh $cert_dir/${common_name}.crt 
#  if test $? -ne 0
#    then
#      echo '{"status":"error","message":"Failed to Delete Cert '$common_name'"}'
#       exit 2
#  fi

if test -f $key_dir/${common_name}.key
  then
  sudo -n /home/engines/scripts/engine/sudo/_remove_cert.sh $key_dir/${common_name}.key
     if test $? -ne 0
      then
        echo echo '{"status":"error","message":"Failed to Delete Key '$common_name'"}'
        exit 2
     fi
 else
  echo '{"status":"error","message":"No Such Key '$key_dir/${common_name}.key'"}'
  exit 2
fi

exit 0
 	
