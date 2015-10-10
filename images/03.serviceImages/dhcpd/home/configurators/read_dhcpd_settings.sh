#!/bin/bash

if test -f /home/configurators/saved/dhcpd_settings
	then
		cat /home/configurators/saved/dhcpd_settings
	else
		echo ":domain_name=Not Set:netmask=Not Set:subnet=Not Set:start=Not Set:end=Not Set:default_lease=Not Set:max_lease=Not Set:default_gateway=Not Set:dns_server1=Not Set:dns_server2=Not Set:"
fi
exit 0