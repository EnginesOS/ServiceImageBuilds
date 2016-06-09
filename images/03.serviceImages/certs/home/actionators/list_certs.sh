#!/bin/bash




if test $1 = "default"
 then
 domain_name=$2
 default=1
 else
    domain_name=$1
 default=0
 fi
 
cat - > /home/certs/$domain_name.crt
 
  
