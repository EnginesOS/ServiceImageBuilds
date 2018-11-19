#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/dns_forwarders
	then
	. /home/engines/scripts/configurators/saved/dns_forwarders
	echo '{"dns_server":"'$dns_server'","dns_server2":"'$dns_server2'"}'
else
	echo '{"dns_server":"Not Set"}'
fi
exit 0
