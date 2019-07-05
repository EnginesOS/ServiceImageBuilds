#!/bin/sh


if ! test -f /etc/postfix/mailname
 then
 sudo -n /home/engines/scripts/engine/sudo/_set_mailname.sh "smtp.engines.internal"
 fi

if ! test -f /home/engines/scripts/configurators/saved/mail_message_size
  then
    max_size=10240000 /home/engines/scripts/configurators/set_max_send_size.sh
fi

for file in transport generic smarthost_passwd aliases/aliases
 do
  sudo -n /home/engines/scripts/engine/sudo/_postmap.sh $file
done 
