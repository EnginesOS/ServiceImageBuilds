#!/bin/bash

dns_server2=8.8.8.8
default_lease=3600
max_lease=36000

. /home/engines/functions/params_to_env.sh
PARAMS_FILE=/home/engines/scripts/configurators/saved/dhcpd_settings
params_to_file_and_env


required_values="domain_name netmask subnet start end default_gateway dns_server1"
check_required_values


cat /home/engines/templates/dhcpd.conf.tmpl |sed -e /NETMASK/s//$netmask/ -e /DOMAIN_NAME/s//$domain_name/ -e /ENGINES_IP/s//$dns_server1/ -e /OPTIONAL_DNS/s//$dns_server2/ -e /DEFAULT_LEASE/s//$default_lease/ -e /MAX_LEASE/s//$max_lease/ -e /SUBNET/s//$subnet/ -e /RANGE_MIN/s//$start/ -e /RANGE_MAX/s//$end/ -e /GATEWAY/s//$default_gateway/ >/tmp/dhcpd.conf
cp /tmp/dhcpd.conf /home/engines/run/flags
sudo -n /home/engines/scripts/engine/_install_dhcpd_conf.sh
