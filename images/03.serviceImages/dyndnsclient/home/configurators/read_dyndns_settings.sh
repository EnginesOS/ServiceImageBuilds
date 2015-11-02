#!/bin/bash

if test -f /home/configurators/saved/dyndns_settings
	then
		cat /home/configurators/saved/dyndns_settings
	else
		echo ":domain_name:"
fi
exit 0