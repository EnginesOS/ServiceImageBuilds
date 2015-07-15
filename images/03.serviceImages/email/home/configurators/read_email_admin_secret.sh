#!/bin/bash

if test -f /home/configurators/saved/email_admin_secret
	then
		cat /home/configurators/saved/email_admin_secret
	else
		echo "Not Set"
fi