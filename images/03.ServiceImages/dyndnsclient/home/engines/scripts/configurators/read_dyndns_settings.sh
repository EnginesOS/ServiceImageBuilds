#!/bin/sh

if test -f /home/engines/scripts/configurators/saved/dyndns_settings
	then
		. /home/engines/scripts/configurators/saved/dyndns_settings
		echo '{
		"provider":"'$provider'",
		"login":"'$login'",
		"domain_name":"'$domain_name'",
		"password":"'$password'"}'
	else
		echo ""
fi
exit 0