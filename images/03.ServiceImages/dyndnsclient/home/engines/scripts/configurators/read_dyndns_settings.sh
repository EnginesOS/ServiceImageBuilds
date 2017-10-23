#!/bin/bash

if test -f /home/engines/scripts/configurators/saved/dyndns_settings
	then
		cat /home/engines/scripts/configurators/saved/dyndns_settings
	else
		echo ""
fi
exit 0