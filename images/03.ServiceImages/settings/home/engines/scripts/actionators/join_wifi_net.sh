#!/bin/sh
. /home/engines/functions/params_to_env.sh
params_to_env
export SSID PSK
sudo -n /home/engines/scripts/actionators/sudo/_join_wifi_net.sh