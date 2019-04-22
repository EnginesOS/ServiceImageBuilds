#!/bin/sh
 . /home/engines/functions/checks.sh

. /home/engines/scripts/engine/backup_dirs.sh

if ! test -z $disabled 
 then
   if  test $disabled = yes
    then
    	rm /home/backup/.gnupg/key_id
    	echo 'OK'
    	exit 0
    fi
fi
required_values="key_id"
check_required_values
 
 if ! test -f /home/backup/.gnupg/pass_${key_id}
  then
   echo "missing saved password"
 	exit 1
 fi
 
 echo ${key_id} > /home/backup/.gnupg/key_id
exit 0   