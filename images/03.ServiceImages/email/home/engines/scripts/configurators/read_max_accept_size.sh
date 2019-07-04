#!/bin/sh
if test -f /home/engines/scripts/configurators/saved/mail_message_size
 then
  max_size=`cat /home/engines/scripts/configurators/saved/mail_message_size`
else
 max_size=10240000
fi 

 
 
