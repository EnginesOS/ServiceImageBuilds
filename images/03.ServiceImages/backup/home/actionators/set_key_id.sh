#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

if ! test -z $disabled 
 then
   if $disabled = yes
    then
    	rm /home/backup/.gnupg/key_id
    	exit 0
    fi
fi

if test -z $key_id
 then
 	echo "missing key"
 	exit 255
 fi
 
 if ! test -f /home/backup/.gnupg/pass_${key_id}
  then
   echo "missing password"
 	exit 255
 fi
 
 echo ${key_id} > /home/backup/.gnupg/key_id
exit 0   