#!/bin/bash

service_hash=$1



 echo $service_hash | /home/engines/bin/json_to_env >/tmp/.env
 . /tmp/.env



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
		mgmt_ip=`cat /opt/engines/etc/net/management`
	ssh  -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i /home/engines/.ssh/mgmt/update_engines_console_password engines@${mgmt_ip} /opt/engines/bin/update_engines_console_password.sh $console_password
 		exit $?	
 	fi
 

