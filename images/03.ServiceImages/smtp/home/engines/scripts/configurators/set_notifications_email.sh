#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/notifications_email
parms_to_file_and_env
     
     
required_values="notifications_email"
check_required_values 


if test -z $postmaster_email
  then
   postmaster_email=$notifications_email fi
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
 eval echo $LINE >> $ALIAS_FILE
done

sudo -n /home/engines/scripts/configurators/_$0