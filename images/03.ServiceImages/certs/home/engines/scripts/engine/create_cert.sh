#!/bin/bash
StoreRoot=/home/certs/store

if test -z $cert_type 
 then
  cert_type=generated
fi

if test $cert_type = user
 then
     cert_type=generated
 else
	StorePref=user
fi
 
sudo -n  /home/engines/scripts/engine/_fix_perms.sh

mkdir -p $StoreRoot/$cert_type/keys/$StorePref
mkdir -p $StoreRoot/$cert_type/certs/$StorePref
 
if test -z $wild
 then
  wild="false"
fi
 
 # before any addition of *\.
domain_name_saved=$domain_name 
if test -z "$country" -a -z "$state" -a -z "$organisation"
 then
 . $StoreRoot/default_cert_details
 fi
echo $country >/home/certs/saved/${cert_name}_setup
echo $state >>/home/certs/saved/${cert_name}_setup
echo $city >>/home/certs/saved/${cert_name}_setup
echo $organisation >>/home/certs/saved/${cert_name}_setup
echo $person >>/home/certs/saved/${cert_name}_setup

if test  $wild = "true"
 then
  echo \*.$domain_name  >>/home/certs/saved/${cert_name}_setup
  hostname=\*.$domain_name
  alt_names="$alt_names ${parent_engine}.${domain_name}" 	
else
  echo $domain_name >>/home/certs/saved/${cert_name}_setup
fi
 
if ! test $altName
 then
  	ALTNAME=DNS:$domain_name_saved
else
  	ALTNAME=DNS:$altName
fi
export ALTNAME=$ALTNAME

echo "" >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup
if test -z $hostname
 then
	hostname=$domain_name_saved
fi

cat /home/engines/templates/certs/request.template | sed -e "s/COUNTRY/$country/"  -e "s/STATE/$state/" -e "s/ORGANISATION/$organisation/" -e "s/PERSON/$person/" -e "s/DOMAINNAME/$domain/" -e "s/HOSTNAME/$hostname/" >  /home/certs/saved/${cert_name}_config

n=2
if ! test -z "$alt_names"
 then
 	for alt_name in $alt_names
 	 do
 	  echo DNS.$n = $alt_name >> /home/certs/saved/${cert_name}_config
 	  n=`expr $n + 1`
 	done
fi

cat /etc/ssl/openssl.cnf /home/certs/saved/${cert_name}_config >/home/certs/saved/${cert_name}_config_full
openssl genrsa -out  $StoreRoot/$cert_type/keys/${StorePref}${cert_name}.key.tmp 2048
openssl req -new  -key $StoreRoot/$cert_type/keys/${StorePref}${cert_name}.key.tmp -out /home/certs/saved/${cert_name}.csr -config /home/certs/saved/${cert_name}_config

if ! test -f /home/certs/saved/${cert_name}.csr 
  then
 	echo "Failed to Create CSR"
 	exit 127
fi

openssl x509 -req -in /home/certs/saved/${cert_name}.csr -sha256 -CA  $StoreRoot/public/ca/certs/system_CA.pem -CAkey $StoreRoot/private/ca/keys/system_CA.key -CAcreateserial -out $StoreRoot/$cert_type/certs/${StorePref}${cert_name}.crt.tmp -days 500  -extensions req_ext -extfile  /home/certs/saved/${cert_name}_config
if test $? -ne 0
 then
 	echo "Failed to sign CSR"
 	exit 127
fi

if test -f $StoreRoot/$cert_type/keys/${StorePref}/${cert_name}.key.tmp -a -f $StoreRoot/$cert_type/certs/${StorePref}/${cert_name}.crt.tmp
 then 
   domain_name=`cat  $StoreRoot/$cert_type/certs/${StorePref}/${cert_name}.crt.tmp | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*/s///"`
   mv $StoreRoot/$cert_type/keys/${StorePref}/${cert_name}.key.tmp $StoreRoot/$cert_type/keys/${StorePref}${domain_name}.key
   mv $StoreRoot/$cert_type/certs/${StorePref}/${cert_name}.crt.tmp $StoreRoot/$cert_type/certs/${StorePref}${domain_name}.crt 
else
   echo "Cert and Key files not present"
   exit 127
 fi
   
if test -z ${install_target}
  then
  install_target=${container_type}s/${parent_engine}
fi
if ! test $cert_type = user
 then
  sudo -n /home/engines/scripts/engine/_install_target.sh ${install_target} $cert_type ${StorePref}/${domain_name} ${domain_name}
  echo  sudo -n /home/engines/scripts/engine/_install_target.sh ${install_target} $cert_type ${StorePref}/${domain_name} ${domain_name}
  exit $?
fi
exit 0