#!/bin/sh
 . /home/engines/functions/checks.sh
 
dns_server2=8.8.8.8
default_lease=3600
max_lease=36000


PARAMS_DIR=/home/engines/scripts/configurators/saved/
echo -n $domain_name > $PARAMS_DIR/domain_name
echo -n $subnet > $PARAMS_DIR/subnet
echo -n $start > $PARAMS_DIR/start
echo -n $end > $PARAMS_DIR/end
echo -n $default_lease > $PARAMS_DIR/default_lease
echo -n $default_gateway > $PARAMS_DIR/default_gateway
echo -n $dns_server1 > $PARAMS_DIR/dns_server1
echo -n $dns_server2 > $PARAMS_DIR/dns_server2
echo -n $netmask > $PARAMS_DIR/netmask

required_values="domain_name netmask subnet start end default_gateway dns_server1"
check_required_values


cat /home/engines/templates/dhcpd.conf.tmpl |sed -e /NETMASK/s//$netmask/ -e /DOMAIN_NAME/s//$domain_name/ -e /ENGINES_IP/s//$dns_server1/ -e /OPTIONAL_DNS/s//$dns_server2/ -e /DEFAULT_LEASE/s//$default_lease/ -e /MAX_LEASE/s//$max_lease/ -e /SUBNET/s//$subnet/ -e /RANGE_MIN/s//$start/ -e /RANGE_MAX/s//$end/ -e /GATEWAY/s//$default_gateway/ >/tmp/dhcpd.conf
cp /tmp/dhcpd.conf /home/engines/run/flags
sudo -n /home/engines/scripts/engine/sudo/_install_dhcpd_conf.sh
