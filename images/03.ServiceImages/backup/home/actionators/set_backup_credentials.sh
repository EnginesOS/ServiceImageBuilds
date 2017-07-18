#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env



if test -z "$pub_key"
 then
  echo "Missing Public key"
  exit 127
fi

if test -z "$priv_key"
 then
  echo "Missing Private key"
  exit 127
fi

if test -z $backup_password
 then
  echo "Missing Password"
  exit 127
fi

key_id=`echo $priv_key |\
 gpg --allow-secret-key-import --import - 2>&1 |\
 grep "secret key imported" |\
  awk '{print $3}' | sed "/:/s///"`

if test $? -ne 0
 then
  echo Error with import $key_id
  exit 127
  fi 

if test -z $key_id
 then
  echo import failed
  exit 127
fi

echo $key_id > /home/backup/.gnupg/key_id
echo $backup_password > /home/backup/.gnupg/pass_${key_id}
echo $backup_password > /home/backup/.gnupg/pass

echo "OK"
exit 0
	  