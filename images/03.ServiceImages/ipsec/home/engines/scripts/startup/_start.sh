#!/bin/sh
PID_FILE=/home/engines/run/ipsec.pid
. /home/engines/functions/system_functions.sh


iptables -t nat -I POSTROUTING -s  10.1.1.0/24 -o eth+ -m policy --dir out --pol ipsec -j ACCEPT
iptables -t nat -I POSTROUTING -s 10.1.1.0/24 -o eth+ -j MASQUERADE
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -I INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

#above was  masq now accept
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.rp_filter=0
sysctl -w net.ipv4.conf.default.accept_source_route=0
sysctl -w net.ipv4.conf.default.send_redirects=0
sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1

cat /home/ivpn/entries/sites/*/nat | while read LINE
do
 echo $LINE |grep -v \# >/dev/null
 if test $? -eq 0
  then
    iptables $LINE
  fi  
done

/usr/sbin/ipsec start --nofork &

echo $! > $PID_FILE
wait



