#!/bin/sh
 . /home/engines/functions/checks.sh


     
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
     echo "notifications_email=$notifications_email
     		postmaster_email=$postmaster_email
     		hostmaster_email=$hostmaster_email
     		webmaster_email=$webmaster_email
     "> /home/engines/scripts/configurators/saved/notifications_email

ALIAS_FILE=/tmp/aliases
cat /home/engines/templates/aliases | while read LINE
do
 eval echo "$LINE" >> $ALIAS_FILE
done

sudo -n /home/engines/scripts/configurators/sudo/_set_notifications_email.sh


