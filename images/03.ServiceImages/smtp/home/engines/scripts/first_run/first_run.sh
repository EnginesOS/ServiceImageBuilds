#!/bin/bash

sudo -n /home/engines/scripts/first_run/_setup_dirs.sh
 
if ! test -f /etc/postfix/mailname
 then
 sudo -n /home/engines/scripts/engine/_set_mailname.sh "not.set"
fi

   sudo -n /home/engines/scripts/engine/_postmap.sh transport
   sudo -n /home/engines/scripts/engine/_postmap.sh generic
   sudo -n /home/engines/scripts/engine/_postmap.sh smarthost_passwd
   sudo -n /home/engines/scripts/engine/_postmap.sh aliases/aliases