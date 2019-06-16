#!/bin/sh
sudo -n /home/engines/scripts/engine/sudo/_fix_perms.sh
. /home/engines/scripts/engine/cert_dirs.sh

if ! test -d /home/certs/store/pending_csr/
 then 
  mkdir /home/certs/store/pending_csr/
fi

  
export StorePref key_dir cert_dir common_name country state city organisation person cert_type container_type parent_engine  

owner_type=$container_type
owner=$parent_engine
resolve_cert_dir
resolve_key_dir

#isUserCert=0
#if test -z $cert_type
# then
#  cert_type=generated
#  StorePref=${container_type}s/${parent_engine}
#elif test $cert_type = user
# then
#	StorePref=
#	isUserCert=1
#else
#   StorePref=${container_type}s/${parent_engine}
#fi

key_dir=$StoreRoot/$cert_type/keys/${StorePref}
cert_dir=$StoreRoot/$cert_type/certs/${StorePref}


mkdir -p $key_dir $cert_dir
/home/engines/scripts/engine/create_csr.sh



if ! test -f $pending_csr_dir/${common_name}.csr 
  then
 	echo '{"status":"error","Message":"Failed to load CSR for '${common_name}'"}'
 	exit 2
fi


openssl x509 -req -in $pending_csr_dir/${common_name}.csr -sha256 -CA  $StoreRoot/public/ca/certs/${ca_name}_CA.pem -CAkey $StoreRoot/private/ca/keys/${ca_name}_CA.key -CAcreateserial -out $cert_dir/${common_name}.crt.tmp -days 500  -extensions req_ext
# -extfile  $setup_dir/${common_name}_config
if test $? -ne 0
 then
 	echo '{"status":"error","Message":"Failed to load Sign CSR for '${common_name}'"}'
 	exit 2
fi
mv $pending_csr_dir/${common_name}.csr $completed_csr_dir/

   common_name=`cat  $cert_dir/${common_name}.crt.tmp | openssl x509 -noout -subject  |sed "/.*CN.*= /s///"| sed "/\*\./s///"`
 
   echo mv $cert_dir/${common_name}.crt.tmp $cert_dir/${common_name}.crt  >/tmp/certscp

  mv $cert_dir/${common_name}.crt.tmp $cert_dir/${common_name}.crt 
 
 if test $isUserCert -eq 1
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
     	 cert_path=services/wap
     else
       dest_name=${common_name}    
     fi
   else
     dest_name=${common_name} 
   fi
   
 echo /home/engines/scripts/engine/_install_target.sh ${cert_path} $cert_type ${StorePref}/${common_name} ${dest_name}
 echo /home/engines/scripts/engine/_install_target.sh ${cert_path} $cert_type ${StorePref}/${common_name} ${dest_name} >>/tmp/callinstall
 sudo -n /home/engines/scripts/engine/sudo/_install_target.sh ${cert_path} $cert_type ${StorePref}/${common_name} ${dest_name}
  
  exit $?
fi


exit 0