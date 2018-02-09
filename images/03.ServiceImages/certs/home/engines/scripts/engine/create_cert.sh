#!/bin/bash
sudo -n /home/engines/scripts/engine/_fix_perms.sh
StoreRoot=/home/certs/store

cert_name=` echo $common_name | sed "s/$.//"` 

if test -z $cert_type 
 then
  cert_type=generated
fi

if test $cert_type = user
 then
    cert_type=generated
	StorePref=user
  else
   StorePref=${container_type}s/${parent_engine}
fi
 


key_dir=$StoreRoot/$cert_type/keys/${StorePref}
cert_dir=$StoreRoot/$cert_type/certs/${StorePref}
setup_dir=/home/certs/saved

mkdir -p $key_dir
mkdir -p $cert_dir
 
if test -z $wild
 then
  wild="false"
fi

if test -z "$country" -a -z "$state" -a -z "$organisation"
 then
 . $StoreRoot/default_cert_details
fi

echo $country >$setup_dir/${cert_name}_setup
echo $state >>$setup_dir/${cert_name}_setup
echo $city >>$setup_dir/${cert_name}_setup
echo $organisation >>$setup_dir/${cert_name}_setup
echo $person >>$setup_dir/${cert_name}_setup



if test $wild = true
 then
  echo \*.$common_name >> $setup_dir/${cert_name}_setup
  alt_names="$alt_names  ${common_name}" 
  CN='\\*.'$common_name	
else
  CN=$common_name	
  echo $common_name >> $setup_dir/${cert_name}_setup
fi

 echo "" >>$setup_dir/${cert_name}_setup
if ! test $altName
 then
  	ALTNAME=DNS:$common_name
else
  	ALTNAME=DNS:$altName
fi
export ALTNAME=$ALTNAME

echo "" >>$setup_dir/${cert_name}_setup
echo "" >>$setup_dir/${cert_name}_setup
echo "" >>$setup_dir/${cert_name}_setup




cat /home/engines/templates/certs/request.template | sed -e "s/COUNTRY/$country/"  \
													-e "s/STATE/$state/" -e "s/ORGANISATION/$organisation/" \
													-e "s/PERSON/$person/" -e "s/COMMON_NAME/$CN/" \
													-e "s/HOSTNAME/$hostname/" >  $setup_dir/${cert_name}_config

n=2
if ! test -z "$alt_names"
 then
 	for alt_name in $alt_names
 	 do
 	  echo DNS.$n = $alt_name >> $setup_dir/${cert_name}_config
 	  n=`expr $n + 1`
 	done
fi

cat /etc/ssl/openssl.cnf $setup_dir/${cert_name}_config >$setup_dir/${cert_name}_config_full
openssl genrsa -out  $key_dir/${cert_name}.key.tmp 2048
openssl req -new  -key $key_dir/${cert_name}.key.tmp -out $setup_dir/${cert_name}.csr -config $setup_dir/${cert_name}_config

if ! test -f $setup_dir/${cert_name}.csr 
  then
 	echo "Failed to Create CSR"
 	exit 127
fi

openssl x509 -req -in $setup_dir/${cert_name}.csr -sha256 -CA  $StoreRoot/public/ca/certs/system_CA.pem -CAkey $StoreRoot/private/ca/keys/system_CA.key -CAcreateserial -out $cert_dir/${cert_name}.crt.tmp -days 500  -extensions req_ext -extfile  $setup_dir/${cert_name}_config
if test $? -ne 0
 then
 	echo "Failed to sign CSR"
 	exit 127
fi

if test -f $key_dir/${cert_name}.key.tmp -a -f $cert_dir/${cert_name}.crt.tmp
 then 
   common_name=`cat  $cert_dir/${cert_name}.crt.tmp | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*\./s///"`
   mv $key_dir/${cert_name}.key.tmp $key_dir/${common_name}.key
   mv $cert_dir/${cert_name}.crt.tmp $cert_dir/${common_name}.crt 
else
   echo "Cert and Key files not present"
   exit 127
 fi
 
 if ! test -z $container_type
 then
 	cert_path=${container_type}s/${parent_engine}
 else
     cert_type = user
 fi	
 
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


if ! test $cert_type = user
 then
 echo /home/engines/scripts/engine/_install_target.sh ${cert_path} $cert_type ${StorePref}/${common_name} ${dest_name}
 echo /home/engines/scripts/engine/_install_target.sh ${cert_path} $cert_type ${StorePref}/${common_name} ${dest_name} >>/tmp/callinstall
 sudo -n /home/engines/scripts/engine/_install_target.sh ${cert_path} $cert_type ${StorePref}/${common_name} ${dest_name}
  
  exit $?
fi
exit 0