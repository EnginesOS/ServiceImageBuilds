#!/bin/bash

if test $# -eq 0 
 then
 	cat -  | /home/engines/bin/json_to_env>/tmp/.env
 else
	echo $1 | /home/engines/bin/json_to_env >/tmp/.env
fi

 . /tmp/.env

#FIXME make engines.internal settable
if test -z "${cert_name}"
	then
		echo Error:Missing cert_name
        exit -1
    fi

    StorePref=${container_type}_${parent_engine}
    
    mkdir -p /home/certs/store/public/keys/
    mkdir -p /home/certs/store/public/certs/
    


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
	
	domainname=\*.$domainname
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
	hostname=$parent_engine.$domain
 fi
 cat /home/request.template | sed -e "s/COUNTRY/$country/"  -e "s/STATE/$state/" -e "s/ORGANISATION/$organisation/" -e "s/PERSON/$person/" -e "s/DOMAINNAME/$domain/" -e "s/HOSTNAME/$hostname/" >  /home/certs/saved/${cert_name}_config

n=2
if ! test -z $alt_names
 then
 	for alt_name in $alt_names
 	 do
 	  echo DNS.$n = $alt_name >> /home/certs/saved/${cert_name}_config
 	  n=`expr $n + 1`
 	 done
 fi
cat /etc/ssl/openssl.cnf /home/certs/saved/${cert_name}_config >/home/certs/saved/${cert_name}_config_full
openssl genrsa -out  /home/certs/store/public/keys/${StorePref}_${cert_name}.key.tmp 2048
#openssl req -new  -extensions v3_req  -key /home/certs/store/public/keys/${StorePref}_${cert_name}.key.tmp -out /home/certs/saved/${cert_name}.csr < /home/certs/saved/${cert_name}_setup
openssl req -new  -key /home/certs/store/public/keys/${StorePref}_${cert_name}.key.tmp -out /home/certs/saved/${cert_name}.csr -config /home/certs/saved/${cert_name}_config_full
if test $? -ne 0
 then
 	echo "Failed to Create CSR"
 	exit 127
 fi

openssl x509 -req -in /home/certs/saved/${cert_name}.csr -sha256 -CA  /home/certs/store/public/ca/certs/system_CA.pem -CAkey /home/certs/store/private/ca/keys/system_CA.key -CAcreateserial -out /home/certs/store/public/certs/${StorePref}_${cert_name}.crt.tmp -days 500  -extensions req_ext -extfile  /home/certs/saved/${cert_name}_config
if test $? -ne 0
 then
 	echo "Failed to sign CSR"
 	exit 127
 fi
  if test -f  /home/certs/store/public/keys/${StorePref}_${cert_name}.key.tmp -a -f /home/certs/store/public/certs/${StorePref}_${cert_name}.crt.tmp
   then
    cp /home/certs/store/public/keys/${StorePref}_${cert_name}.key.tmp /home/certs/store/public/keys/${StorePref}_${cert_name}.key
    cp /home/certs/store/public/certs/${StorePref}_${cert_name}.crt.tmp /home/certs/store/public/certs/${StorePref}_${cert_name}.crt
   
   else
    echo "Cert and Key files not present"
    exit 127
   fi
echo "Success"
exit 0
