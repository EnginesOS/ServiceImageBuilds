#!/bin/bash

if test -f /home/configurators/saved/default_mdns_domain
	then
		cat /home/configurators/saved/default_mdns_domain
	else
	echo '{"default_mdns_domain":"Not Set"}'

fi
exit 0