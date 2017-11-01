#!/bin/bash
. /home/engines/functions/params_to_env.sh
params_to_env

required_values="cert_name store target"
check_required_values

sudo -n  /home/engines/scripts/engine/_install_target.sh ${target} ${store}/${cert_name} default