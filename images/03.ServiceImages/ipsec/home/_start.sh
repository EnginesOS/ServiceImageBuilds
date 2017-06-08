#!/bin/sh


iptables -t nat -I POSTROUTING -s  10.1.1.0/24 -o eth+ -m policy --dir out --pol ipsec -j ACCEPT
iptables -t nat -I POSTROUTING -s 10.1.1.0/24 -o eth+ -j MASQUERADE

iptables -t mangle -A FORWARD --match policy --pol ipsec --dir in -s 10.1.1.0/24 -o eth0 -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:1536 -j TCPMSS --set-mss 1360
#below is new
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -I INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j MASQUERADE
#above was accept not masq
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.rp_filter=0
sysctl -w net.ipv4.conf.default.accept_source_route=0
sysctl -w net.ipv4.conf.default.send_redirects=0
sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
sudo /usr/sbin/ipsec start --nofork &
dmesg
wait