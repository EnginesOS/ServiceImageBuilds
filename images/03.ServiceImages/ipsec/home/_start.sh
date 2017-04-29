#!/bin/sh

iptables -t nat -I POSTROUTING -s 10.1.1.0/24 -o eth+ -j MASQUERADE
iptables -t nat -I POSTROUTING -s  10.1.1.0/24 -o eth+ -m policy --dir out --pol none -j MASQUERADE
sysctl -w net.ipv4.ip_forward=1

sudo /usr/sbin/ipsec start -no fork &
wait