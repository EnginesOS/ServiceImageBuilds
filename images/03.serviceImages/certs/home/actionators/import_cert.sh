#!/bin/bash


if test $1 = "default"
 then
 domain_name=$2
 default=1
 else
    domain_name=$1
 default=0
 fi
 rm /home/certs/store/public/certs/$domain_name.crt
 rm /home/certs/store/public/keys/$domain_name.key
 
 while read line; do
 # echo "reading: ${line}"
  echo ${line} |grep  "BEGIN CERTIFICATE"
  	if test $? -eq 0
  		then
  			file=/home/certs/store/public/certs/$domain_name.crt
  		fi
  		 echo ${line} |grep "BEGIN RSA PRIVATE KEY"
  		if test $? -eq 0
  		then
  			file=/home/certs/store/public/keys/$domain_name.key
  		fi 
  		
  		echo ${line} >> $file
  		
  		 echo ${line} |grep "END RSA PRIVATE KEY"  		
  		if test $? -eq 0
  		then
  		echo true
  			exit
  		fi 
  		
done < /dev/stdin

 