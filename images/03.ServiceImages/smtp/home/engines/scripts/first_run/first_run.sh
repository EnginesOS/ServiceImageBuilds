#!/bin/bash

sudo -n /home/engines/scripts/first_run/_setup_dirs.sh

if ! test -f /home/postfix/transport 
 then
	 echo "*	smtp:" >/home/postfix/transport
fi 
if ! test -f /etc/postfix/mailname
 then
 sudo -n /home/engines/scripts/engine/_set_mailname.sh "not.set"
fi

sudo -n /home/engines/scripts/engine/_postmap.sh transport

	touch	/home/postfix/generic
	sudo -n /home/engines/scripts/engine/_postmap.sh generic
	
	touch /home/postfix/smarthost_passwd
	sudo -n /home/engines/scripts/engine/_postmap.sh smarthost_passwd