#!/bin/sh
cp /tmp/dhcpd.conf /etc/dhcp
touch /tmp/restart_dhcp
chown dhcpd /tmp/restart_dhcp
kill `cat /var/run/dhcpd.pid`

