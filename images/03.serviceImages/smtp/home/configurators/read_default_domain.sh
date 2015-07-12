#!/bin/bash

if test -f /home/configurators/saved/default_domain
	then
		cat /home/configurators/saved/default_domain
	else
		echo "Not Set"
fi