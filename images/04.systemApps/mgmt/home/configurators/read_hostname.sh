#/bin/bash

#!/bin/bash

if test -f /home/configurators/saved/hostname
	then
		cat /home/configurators/saved/hostname
	else
		echo ":hostname=:domain_name=:"
fi

exit 0