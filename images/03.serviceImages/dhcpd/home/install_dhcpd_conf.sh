#!/bin/sh
cp /tmp/dhcpd.conf /etc/dhcp
touch /tmp/restart_dhcp
kill `cat /var/run/dhcpd.pid`
sleep 15
rm /tmp/restart_dhcp
