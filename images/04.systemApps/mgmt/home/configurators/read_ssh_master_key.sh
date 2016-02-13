#!/bin/bash

if test -f /home/engines/.ssh/authorized_keys
	then
		key=`cat /home/engines/.ssh/authorized_keys |awk '{print $2}'`
			echo '{"ssh_master_key":"'$key'"}'		
	else
		echo '{"ssh_master_key":"Not Saved"}'
fi

