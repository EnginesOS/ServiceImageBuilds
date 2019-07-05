#!/bin/sh

 . /home/engines/functions/checks.sh
required_values="max_size"
check_required_values
 
 if test -f /home/engines/scripts/configurators/saved/mail_message_size
 then 
   curr=`cat /home/engines/scripts/configurators/saved/mail_message_size`
    if test $curr -eq $max_size
      then 
       exit 0
    fi
fi      

echo -n $max_size > /home/engines/scripts/configurators/saved/mail_message_size
 
sudo -n /home/engines/scripts/configurators/sudo/rebuild_main.sh
