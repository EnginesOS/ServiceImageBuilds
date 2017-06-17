#!/bin/bash

. /home/engines/functions/params_to_env.sh
parms_to_env
 
default_mdns_domain=`cat /home/configurators/saved/default_mdns_domain  | cut -f2 -d: | sed "s/\"//" | cut -f1 -d\"`

echo "delete from action_tests where name = '$name';"
if test -z ${hostname}
  then
	echo Error:Missing hostname
    exit 128
fi


touch /home/avahi/hosts/${hostname}.${default_mdns_domain}
ls /home/avahi/hosts/ > /home/avahi/hosts_list
  if test -f /tmp/avahi-publisher.pid
	then
	  kill -HUP `cat /tmp/avahi-publisher.pid`
  fi

	
#	ps -ax |grep -v grep |grep avahi-alias.py
#
#	 if test $? -ne 0
#	  then
#	  		echo "avahi publisher had crashed"
#			python /home/avahi-alias.py &
#			echo $! >/tmp/avahi-publisher.pid			
#	fi
#
echo Success
exit 0

	
