#!/bin/bash


if ! test -f /etc/postfix/mailname
 then
 sudo -n /home/engines/scripts/engine/_set_mailname.sh "not.set"
fi

for file in transport generic smarthost_passwd aliases/aliases
 do
  sudo -n /home/engines/scripts/engine/_postmap.sh $file
done 
