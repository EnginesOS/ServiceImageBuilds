#!/bin/sh
#. /home/engines/functions/params_to_env.sh
#params_to_env
 . /home/engines/functions/checks.sh
export SSID PSK
sudo -n /home/engines/scripts/actionators/sudo/_join_wifi_net.sh