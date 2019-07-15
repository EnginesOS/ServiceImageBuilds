#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/smarthost
then
	. /home/engines/scripts/configurators/saved/smarthost
	 echo '{"smart_hostname":"'$smart_hostname'",
           "smart_host_port":"'$smart_host_port'",
           "smart_host_user":"'$smart_host_user'",
           "smart_host_passwd":"'$smart_host_passwd'"} '
else
	echo '{"smarthost_hostname":"Not Set"}'
fi
exit 0