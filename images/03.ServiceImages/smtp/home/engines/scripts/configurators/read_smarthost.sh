#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/smarthost
then
	. /home/engines/scripts/configurators/saved/smarthost
	 echo '{"smart_hostname":"'$smart_hostname'",
           "smart_host_port":"'$smart_host_port'",
           "smarthost_username":"'$smarthost_username'",
           "smarthost_password":"'$smarthost_password'"} '
else
	echo '{"smarthost_hostname":"Not Set"}'
fi
exit 0