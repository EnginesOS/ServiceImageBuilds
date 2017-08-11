#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env

sudo -n /home/actionators/_fix_perms.sh

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

#res=`echo $priv_key \
#     | sed "/\\\r/s///g" | sed "/\\\n/s//\n/g" \
#     | gpg --allow-secret-key-import --import - 2>&1`

echo $priv_key |  sed "/\\\r/s///g" | sed "/\\\n/s//\n/g" >/tmp/.tt
res=` cat /tmp/.tt | gpg --allow-secret-key-import --import - 2>&1`


if test $? -ne 0
 then
  echo Error with import $res
  rm /tmp/.tt
  exit 127
  fi 
  
rm /tmp/.tt
  
key_id=`echo $res \
       | grep "secret key imported"\
       | awk '{print $3}' | sed "/:/s///"`
  
if test -z $key_id
 then
  echo $priv_key |\
  sed "/\\\r/s///g" | sed "/\\\n/s//\n/g"  >/tmp/p
  echo import failed $res
  exit 127
fi

echo $key_id > /home/backup/.gnupg/key_id
echo $backup_password > /home/backup/.gnupg/pass_${key_id}
echo $backup_password > /home/backup/.gnupg/pass

/home/actionators/trust_key.expect $key_id 

echo "OK"
exit 0
	  