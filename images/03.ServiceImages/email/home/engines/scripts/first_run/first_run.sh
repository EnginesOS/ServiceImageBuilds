#!/bin/bash

touch /home/email/smarthost_passwd 
touch /home/email/generic 
touch /home/email/transport
sudo -n /home/engines/scripts/engine/_postmap.sh transport 
sudo -n /home/engines/scripts/engine/_postmap.sh smarthost_passwd
sudo -n /home/engines/scripts/engine/_postmap.sh generic
 
sudo -n /home/engines/scripts/first_run/_setup_dirs.sh