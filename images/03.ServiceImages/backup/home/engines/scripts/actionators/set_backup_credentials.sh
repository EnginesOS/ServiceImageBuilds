#!/bin/sh

. /home/engines/scripts/engine/backup_dirs.sh


sudo -n /home/engines/scripts/actionators/sudo/_fix_perms.sh

required_values="pub_key priv_key backup_password"
check_required_values


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

/home/engines/scripts/actionators/trust_key.expect $key_id 

echo "OK"
exit 0
	  