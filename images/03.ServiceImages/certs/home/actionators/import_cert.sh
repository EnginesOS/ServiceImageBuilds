#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

if test -z ${domain_name}
 then
  echo Missig cert_name
  exit 255
fi

if test -z ${certificate}
 then
  echo Missig certificate
  exit 255
fi
if test -z ${key}
 then
  echo Missig key
  exit 255
fi

rm /home/certs/store/public/certs/$domain_name.crt &>/dev/null
 
rm /home/certs/store/public/keys/$domain_name.key &>/dev/null
 
echo ${key} > /home/certs/store/public/keys/$domain_name.key
echo ${certificate} > /home/certs/store/public/certs/$domain_name.crt
 
#while read line; do
## echo "reading: ${line}"
# echo ${line} |grep  "BEGIN CERTIFICATE" >/dev/null
# 	if test $? -eq 0
# 	 then
# 		file=/home/certs/store/public/certs/$domain_name.crt
# 	fi
# echo ${line} |grep "BEGIN RSA PRIVATE KEY">/dev/null
# 	if test $? -eq 0
# 	 then
# 		file=/home/certs/store/public/keys/$domain_name.key
# 	fi 
# 		
# echo ${line} >> $file	
# echo ${line} |grep "END RSA PRIVATE KEY"  		>/dev/null
# 	if test $? -eq 0
# 	 then
# 	   echo true
# 	   exit 0
# 	fi 
#done < /dev/stdin
#
#