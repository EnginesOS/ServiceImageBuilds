#!/bin/sh
 . /home/engines/functions/checks.sh

     echo $notifications_email > /home/engines/scripts/configurators/saved/notifications_email
     
required_values="notifications_email"
check_required_values 


if test -z $postmaster_email
  then
   postmaster_email=$notifications_email 
fi
if test -z $hostmaster_email
  then
   hostmaster_email=$notifications_email
fi
if test -z $webmaster_email
  then
   webmaster_email=$notifications_email
fi 


ALIAS_FILE=/tmp/aliases
cat /home/engines/templates/aliases | while read LINE
do
 eval echo "$LINE" >> $ALIAS_FILE
done

sudo -n /home/engines/scripts/configurators/_set_notifications_email.sh
echo $0