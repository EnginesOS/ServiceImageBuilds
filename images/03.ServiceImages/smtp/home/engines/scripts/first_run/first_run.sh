#!/bin/bash

sudo -n /home/engines/scripts/engine/_setup_dirs.sh

if ! test -f /home/postfix/transport 
 then
	 echo "	*	smtp:" >/home/postfix/transport
fi 
if ! test -f /etc/postfix/mailname
 then
 sudo -n /home/engines/scripts/engine/_set_mailname.sh "not.set"
fi
		
sudo -n /home/engines/scripts/engine/_postmap.sh transport