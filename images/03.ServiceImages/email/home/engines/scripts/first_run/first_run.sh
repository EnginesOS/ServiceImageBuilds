#!/bin/bash

touch /home/email/smarthost_passwd 
touch /home/email/generic 
touch /home/email/transport
sudo -n /home/engines/scripts/engine/sudo/_postmap.sh transport 
sudo -n /home/engines/scripts/engine/sudo/_postmap.sh smarthost_passwd
sudo -n /home/engines/scripts/engine/sudo/_postmap.sh generic
 
sudo -n /home/engines/scripts/first_run/sudo/_setup_dirs.sh