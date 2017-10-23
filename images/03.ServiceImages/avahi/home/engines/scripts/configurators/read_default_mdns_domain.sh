#!/bin/bash

if test -f /home/engines/scripts/configurators/saved/default_mdns_domain
	then
		cat /home/engines/scripts/configurators/saved/default_mdns_domain
	else
	echo '{"default_mdns_domain":"Not Set"}'

fi
exit 0