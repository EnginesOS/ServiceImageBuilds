#!/bin/sh
sudo -n /home/engines/scripts/engine/_fix_perms.sh
. /home/engines/scripts/engine/cert_dirs.sh

export StorePref key_dir common_name country state city organisation person cert_type container_type parent_engine  

if test $cert_type = user
 then
    cert_type=generated
	StorePref=user
	isUserCert=1
  else
   StorePref=${container_type}s/${parent_engine}
fi
key_dir=$StoreRoot/$cert_type/keys/${StorePref}
cert_dir=$StoreRoot/$cert_type/certs/${StorePref}

/home/engines/scripts/engine/create_csr.sh

if ! test -f $pending_csr_dir/${common_name}.csr 
  then
 	echo "Failed to load CSR for ${common_name}"
 	exit 127
fi


openssl x509 -req -in $pending_csr_dir/${common_name}.csr -sha256 -CA  $StoreRoot/public/ca/certs/system_CA.pem -CAkey $StoreRoot/private/ca/keys/system_CA.key -CAcreateserial -out $cert_dir/${common_name}.crt.tmp -days 500  -extensions req_ext -extfile  $setup_dir/${common_name}_config
if test $? -ne 0
 then
 	echo "Failed to sign CSR"
 	exit 127
fi
mv $pending_csr_dir/${common_name}.csr $completed_csr_dir/

   common_name=`cat  $cert_dir/${common_name}.crt.tmp | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*\./s///"`
 
   echo cp $cert_dir/${common_name}.crt.tmp $cert_dir/${common_name}.crt 

   cp $cert_dir/${common_name}.crt.tmp $cert_dir/${common_name}.crt 
 
 if ! test $isUserCert -eq 1
 then
 	cert_path=user     
 else
  cert_path=${container_type}s/${parent_engine}
   if ! test -z ${install_target}
    then
     if test ${install_target} = default
      then
       dest_name=${parent_engine}
     elif test ${install_target} = wap
      then
     	 dest_name=${common_name}
     	 StorePref=services/wap
     else
       dest_name=${common_name}    
     fi
   else
     dest_name=${common_name} 
   fi
   
 echo /home/engines/scripts/engine/_install_target.sh ${cert_path} $cert_type ${StorePref}/${common_name} ${dest_name}
 echo /home/engines/scripts/engine/_install_target.sh ${cert_path} $cert_type ${StorePref}/${common_name} ${dest_name} >>/tmp/callinstall
 sudo -n /home/engines/scripts/engine/_install_target.sh ${cert_path} $cert_type ${StorePref}/${common_name} ${dest_name}
  
  exit $?
fi


exit 0