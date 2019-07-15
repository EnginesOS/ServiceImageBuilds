#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/mail_message_size
 then
   max_email_size=`cat /home/engines/scripts/configurators/saved/mail_message_size`
 else
    max_email_size=10240000
fi

smart_host_enable='#'
if test -f  /home/engines/scripts/configurators/saved/smarthost
 then
  . /home/engines/scripts/configurators/saved/smarthost
 if ! test $auth_type = none
  then
   smart_host_enable=' '
 fi
fi  

cat /home/engines/templates/main.cf | sed "/MAX_EMAIL_SIZE/s//$max_email_size/" 
									| sed "/SASL_SMART_HOST_ENABLE/s//$smart_host_enable/"	> /etc/postfix/main.cf

/home/engines/scripts/configurators/sudo/_rebuild_main.sh