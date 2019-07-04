#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/mail_message_size
 then
   max_email_size=`cat /home/engines/scripts/configurators/saved/mail_message_size`
 else
    max_email_size=10240000
fi
cat /home/engines/templates/main.cf | sed "/MAX_EMAIL_SIZE/s//$max_email_size/" > /etc/postfix/main.cf

/home/engines/scripts/configurators/sudo/_rebuild_main.sh