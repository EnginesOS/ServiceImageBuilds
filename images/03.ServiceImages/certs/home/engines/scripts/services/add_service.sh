#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

#FIXME make engines.internal settable
if test -z "${cert_name}"
 then
  echo Error:Missing cert_name
  exit -1
fi
if test ${container_type} = system
 then
    StorePref=services/${parent_engine}/
else
   StorePref=${container_type}s/${parent_engine}/
fi

sudo -n  /home/engines/scripts/engine/_fix_perms.sh

mkdir -p /home/certs/store/public/keys/$StorePref
mkdir -p /home/certs/store/public/certs/$StorePref
 
if test -z $wild
 then
  wild="no"
fi
 
 # before any addition of *\.
domain=$domainname 

echo $country >/home/certs/saved/${cert_name}_setup
echo $state >>/home/certs/saved/${cert_name}_setup
echo $city >>/home/certs/saved/${cert_name}_setup
echo $organisation >>/home/certs/saved/${cert_name}_setup
echo $person >>/home/certs/saved/${cert_name}_setup

if test  $wild = "yes"
 then
  echo \*.$domainname  >>/home/certs/saved/${cert_name}_setup
  hostname=\*.$domainname
  domainname=\*.$domainname
  alt_names="$alt_names ${parent_engine}.${domainname}" 	
else
  echo $domainname  >>/home/certs/saved/${cert_name}_setup
fi
 
if ! test $altName
 then
  	ALTNAME=DNS:$domain
else
  	ALTNAME=DNS:$altName
fi
export ALTNAME=$ALTNAME

echo "" >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup
echo "" >>/home/certs/saved/${cert_name}_setup
if test -z $hostname
 then
	hostname=$domain
fi

cat /home/engines/templates/cert_auth/request.template | sed -e "s/COUNTRY/$country/"  -e "s/STATE/$state/" -e "s/ORGANISATION/$organisation/" -e "s/PERSON/$person/" -e "s/DOMAINNAME/$domain/" -e "s/HOSTNAME/$hostname/" >  /home/certs/saved/${cert_name}_config

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
openssl genrsa -out  /home/certs/store/public/keys/${StorePref}${cert_name}.key.tmp 2048
openssl req -new  -key /home/certs/store/public/keys/${StorePref}${cert_name}.key.tmp -out /home/certs/saved/${cert_name}.csr -config /home/certs/saved/${cert_name}_config

if test $? -ne 0
 then
 	echo "Failed to Create CSR"
 	exit 127
fi

openssl x509 -req -in /home/certs/saved/${cert_name}.csr -sha256 -CA  /home/certs/store/public/ca/certs/system_CA.pem -CAkey /home/certs/store/private/ca/keys/system_CA.key -CAcreateserial -out /home/certs/store/public/certs/${StorePref}${cert_name}.crt.tmp -days 500  -extensions req_ext -extfile  /home/certs/saved/${cert_name}_config
if test $? -ne 0
 then
 	echo "Failed to sign CSR"
 	exit 127
fi

if test -f  /home/certs/store/public/keys/${StorePref}${cert_name}.key.tmp -a -f /home/certs/store/public/certs/${StorePref}${cert_name}.crt.tmp
 then
   cp /home/certs/store/public/keys/${StorePref}${cert_name}.key.tmp /home/certs/store/public/keys/${StorePref}${cert_name}.key
   cp /home/certs/store/public/certs/${StorePref}${cert_name}.crt.tmp /home/certs/store/public/certs/${StorePref}${cert_name}.crt 
else
   echo "Cert and Key files not present"
   exit 127
 fi
   
if test ${container_type} = service
 then
  install_target=${parent_engine}
fi
     
if test -z ${install_target}
 then
  install_target=nginx
fi
domain_name=`cat  /home/certs/store/public/certs/${StorePref}${cert_name}.crt | openssl x509 -noout -subject  |sed "/^.*CN=/s///"| sed "/\*/s///"`

sudo -n  /home/engines/scripts/engine/_install_target.sh ${install_target} ${StorePref}/${cert_name} ${domain_name}
 
echo "Success"
exit 0
