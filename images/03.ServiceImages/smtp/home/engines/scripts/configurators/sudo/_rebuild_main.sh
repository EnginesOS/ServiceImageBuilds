#!/bin/sh
 spf_conf=""

truncate --size 0 /home/engines/scripts/configurators/saved/rbls.conf

for rbl in `ls /home/engines/scripts/configurators/saved/antispam |grep -v keep_me`
do
	echo -n ", reject_rbl_client $rbl " >>  /home/engines/scripts/configurators/saved/rbls.conf
done

if test -f /home/engines/scripts/configurators/saved/grey_listing_enabled
  then
  echo -n ",check_policy_service inet:127.0.0.1:60000 " >>  /home/engines/scripts/configurators/saved/rbls.conf
 
fi
echo -n ",permit"  >>  /home/engines/scripts/configurators/saved/rbls.conf

if test -f /home/engines/scripts/configurators/saved/hostname_checks
 then
   hostname_checking=',reject_unknown_hostname,reject_invalid_hostname'
fi   

if test -f /home/engines/scripts/configurators/saved/enforce_spf
 then
  spf_conf=',check_policy_service unix:private\/policyd-spf'
  spf_action=`cat /home/engines/scripts/configurators/saved/enforce_spf_action`
   if test $spf_action = 'reject'
    then
     cp /home/engines/template/spf/reject_spf_policy.conf /etc/postfix-policyd-spf-python/policyd-spf.conf
   else
    cp /home/engines/template/spf/tag_spf_policy.conf /etc/postfix-policyd-spf-python/policyd-spf.conf
   fi
fi  

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
  if test $enabled = true
   then
    if ! test $auth_type = none
     then
      smart_host_enable=''
    fi   
  fi  
fi  


rbl_conf=`cat /home/engines/scripts/configurators/saved/rbls.conf`
cat /home/engines/templates/main.cf | sed "/RBL_CONF/s//$rbl_conf/" \
									      |	sed "/SPF/s//$spf_conf/"  \
									      |	sed "/HOSTNAME_CHECKS/s//$hostname_checking/"  \
									      | sed "/MAX_EMAIL_SIZE/s//$max_email_size/" \
									      | sed "/SASL_SMART_HOST_ENABLE/s//$smart_host_enable/" \
											> /etc/postfix/main.cf

if test -f /home/engines/scripts/configurators/saved/enforce_dkim
  then
  Milter_Frag=`cat /home/engines/templates/main/milters |sed "/DKIM_MILTER/s//inet:localhost:8892/"`
fi  
echo $Milter_Frag >> /etc/postfix/main.cf


/etc/init.d/postfix reload

