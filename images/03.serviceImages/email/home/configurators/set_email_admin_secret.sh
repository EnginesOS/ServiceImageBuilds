#!/bin/bash

service_hash=$1

echo $1 >/home/configurators/saved/email_admin_secret

. /home/engines/scripts/functions.sh

load_service_hash_to_environment


echo $1 |grep = >/dev/null
        if test $? -ne 0
        then
                exit
        fi

res="${1//[^:]}"
echo $res
fcnt=${#res}
fcnt=`expr $fcnt + 1`

        while test $fcnt -ge $n
        do
                nvp="`echo $1 |cut -f$n -d:`"
                n=`expr $n + 1`
                name=`echo $nvp |cut -f1 -d=`
                if ! test -z $name 
                	then
                	value="`echo $nvp |cut -f2 -d=`"
                		if ! test -z $value
                			then
                			export $name="$value"
                		fi
                fi
        done
        
        
   	if test  ${#email_admin_secret} -gt 5
	then  
	salt=`dd if=/dev/urandom count=20 bs=1  | od -h -w | cut -f2- -d" " |head -1 |sed "/[\t ]./s///g" `
 	sec=`echo -n ${salt}:${email_admin_secret} |shasum |cut -f 1 -d" "`
 	cat /home/app/config.inc.php | sed "/\'setup_password\'.*/s//\'setup_password\'\] =\'${salt}:${sec}\';/" > /tmp/config.inc.php 
 	#cat /home/app/config.inc.php | sed "/SETUP_PASSWORD/s//$sec/" > /tmp/config.inc.php 
 	cp 	/tmp/config.inc.php  /home/app/config.inc.php
 			
 	fi
 

