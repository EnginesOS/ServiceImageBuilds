#!/bin/bash


truncate --size 0 /home/configurators/saved/rbls.conf

for rbl in `ls /home/configurators/saved/antispam |grep -v keep_me`
do
	echo -n ", reject_rbl_client $rbl " >>  /home/configurators/saved/rbls.conf
done

if test -f /home/configurators/saved/grey_listing_enabled
  then
  echo -n ",check_policy_service inet:127.0.0.1:60000 " >>  /home/configurators/saved/rbls.conf
 
fi
echo  ",permit"  >>  /home/configurators/saved/rbls.conf

rbl_conf=`cat /home/configurators/saved/rbls.conf`
cat /home/engines/templates/email/main.cf | sed "/RBL_CONF/s//$rbl_conf/" > /etc/postfix/main.cf
kill -HUP `cat /var/spool/postfix/pid/master.pid`
