#!/bin/bash

if test -f /home/configurators/saved/dhcpsettings
	then
		cat /home/configurators/saved/dhcpsettings
	else
		echo ":domain_name=Not Set:netmask=Not Set:subnet=Not Set:start=Not Set:end=Not Set:default_lease=Not Set:max_lease=Not Set:default_gateway=Not Set:dns_server1=Not Set:dns_server2=Not Set:"
fi
exit 0