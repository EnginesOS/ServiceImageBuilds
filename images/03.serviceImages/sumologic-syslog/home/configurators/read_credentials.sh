#!/bin/bash

if test -f /home/configurators/saved/credentials
	then
		cat /home/configurators/saved/credentials
	else
	echo '{"access_id":"Not set","access_key":"Not Saved"}'

fi

exit 0