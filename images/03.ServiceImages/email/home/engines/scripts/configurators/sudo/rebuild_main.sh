#!/bin/sh


truncate --size 0 /home/engines/scripts/configurators/saved/rbls.conf

for rbl in `ls /home/engines/scripts/configurators/saved/antispam |grep -v keep_me`
do
	echo -n ", reject_rbl_client $rbl " >>  /home/engines/scripts/configurators/saved/rbls.conf
done

if test -f /home/engines/scripts/configurators/saved/grey_listing_enabled
  then
  echo -n ",check_policy_service inet:127.0.0.1:60000 " >>  /home/engines/scripts/configurators/saved/rbls.conf
 
fi
echo  ",permit"  >>  /home/engines/scripts/configurators/saved/rbls.conf

if test -f /home/engines/scripts/configurators/saved/hostname_checks
 then
   hostname_checking=',reject_unknown_hostname,reject_invalid_hostname'
fi   

if test -f /home/engines/scripts/configurators/saved/enforce_spf
 then
  spf_conf=',check_policy_service unix:private/policyd-spf'
fi  

rbl_conf=`cat /home/engines/scripts/configurators/saved/rbls.conf`
cat /home/engines/templates/email/main.cf | sed "/RBL_CONF/s//$rbl_conf/" \
									      |	sed "/SPF/s//$spf_conf/"  \
									      |	sed "/HOSTNAME_CHECKS/s//$hostname_checking/"  \
											> /etc/postfix/main.cf
/home/engines/scripts/signal/kill_postfix.sh -HUP