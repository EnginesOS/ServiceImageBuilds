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
        
        
   	if test -n $db_master_pass
	then  
	
	su postgres -c psql  "alter user rma with PASSWORD '$db_master_pass';"
 			
 	fi
 

