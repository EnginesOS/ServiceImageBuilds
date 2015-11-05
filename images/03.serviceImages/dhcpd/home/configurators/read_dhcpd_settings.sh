#!/bin/bash

if test -f /home/configurators/saved/dhcpd_settings
	then
		cat /home/configurators/saved/dhcpd_settings
	else
		echo ":d:"
fi
exit 0