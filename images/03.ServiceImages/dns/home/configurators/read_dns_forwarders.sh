#!/bin/bash

if test -f /home/configurators/saved/dns_forwarders
	then
		cat /home/configurators/saved/dns_forwarders
	else
		echo '{"dns_forwarders":"Not Set"}'
fi
exit 0