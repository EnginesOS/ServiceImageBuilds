#!/bin/bash

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/configurators/saved/email_admin_secret
parms_to_file_and_env
      
 if test  ${#email_admin_secret} -gt 5
 then  
  salt=`dd if=/dev/urandom count=20 bs=1  | od -h -w | cut -f2- -d" " |head -1 |sed "/[\t ]./s///g" `
  sec=`echo -n ${salt}:${email_admin_secret} |shasum |cut -f 1 -d" "`
  cat /home/app/config.inc.php | sed "/setup_password.*/s//setup_password\'\] =\'${salt}:${sec}\';/" > /tmp/config.inc.php 
  #cat /home/app/config.inc.php | sed "/SETUP_PASSWORD/s//$sec/" > /tmp/config.inc.php 
  cp /tmp/config.inc.php /home/app/config.inc.php		
fi
 exit 0

