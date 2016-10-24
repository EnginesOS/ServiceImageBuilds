#!/bin/sh
touch /var/lib/dhcp/dhcpd.leases
cp /tmp/dhcpd.conf /etc/dhcp
touch /tmp/restart_dhcp
chown dhcpd /tmp/restart_dhcp
kill `cat /var/run/dhcpd.pid`

