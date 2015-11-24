#!/bin/bash

service_hash=$1



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
        
        
   	if test -n $console_password
	then  
		subnet=`grep mgmt /etc/hosts|awk '{print $1}' |cut -d. -f-3`
	ssh  -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /home/engines/.ssh/mgmt/update_engines_console_password engines@${subnet}.1 /opt/engines/bin/update_engines_console_password.sh $console_password
 		exit $?	
 	fi
 

