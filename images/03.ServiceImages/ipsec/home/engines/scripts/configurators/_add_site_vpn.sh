#!/bin/bash

function add_site_vpn {
cp /tmp/.env /home/ivpn/entries/site/${vpn_name}
}

. /home/engines/functions/params_to_env.sh
params_to_env

required_values="vpn_name remote_site remote_lan remote_id psk"
check_required_values

add_site_vpn

echo "Success"
exit 0
