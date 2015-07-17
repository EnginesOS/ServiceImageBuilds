#!/bin/bash

if test -f /home/configurators/saved/default_site
	then
		cat /home/configurators/saved/default_site
	else
		echo ":default_site=Not Set:"
fi