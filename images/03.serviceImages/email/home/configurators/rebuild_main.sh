#!/bin/bash

cp /home/tmpls/main.cf >/etc/postfix/main.cf

for rbl in `ls /home/configurators/saved/antispam`
do
	echo -n ", reject_rbl_client $rbl " >> /etc/postfix/main.cf
done

 if test -f /home/configurators/saved/grey_listing_enabled
  then
  echo -n ",check_policy_service inet:127.0.0.1:60000 " >> /etc/postfix/main.cf
  fi
echo  ",permit"  >> /etc/postfix/main.cf


kill -HUP `cat /var/spool/postfix/pid/master.pid`
