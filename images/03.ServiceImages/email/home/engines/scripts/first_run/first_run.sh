#!/bin/bash

touch /home/email/maps/smarthost_passwd 
touch /home/email/maps/generic 
touch /home/email/maps/transport
sudo -n /home/engines/scipts/engine/_postmap transport 
sudo -n /home/engines/scipts/engine/_postmap smarthost_passwd
sudo -n /home/engines/scipts/engine/_postmap generic
 
sudo -n /home/engines/scripts/first_run/_setup_dirs.sh