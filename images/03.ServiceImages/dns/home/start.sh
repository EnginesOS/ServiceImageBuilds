#!/bin/bash


grep BLANK /var/lib/bind/engines/engines.dnsrecords >/dev/null

if test $? -eq 0
 then
   ip_r=`grep dns /etc/hosts|awk '{print $1}' |cut -d. -f-3`
   ip=${ip_r}.1
   net=`echo $ip_r |awk  ' BEGIN {  FS="."} {print $2 "." $1}'`
   cat  /home/engines/templates/dns/engines.internal.domain.tmpl |sed "/IP/s//$ip/" > /var/lib/bind/engines/engines.dnsrecords
   cat  /home/engines/templates/dns/engines.internal.in-addr.arpa.tmpl |sed "/NET/s//$net/g" > /var/lib/bind/engines/engines.in-addr.arpa.dnsrecords
fi

PID_FILE=/var/run/named/named.pid
export PID_FILE
. /home/engines/functions/trap.sh



sudo -n /home/engines/scripts/engine/_setup.sh


sudo -n /usr/sbin/named  -c /etc/bind/named.conf -f -u bind &
touch /home/engines/run/flags/startup_complete

. /home/engines/scripts/services/dns_functions.sh
hostname=lanhost
ip=`cat  /opt/engines/etc/net/ip`
add_to_internal_domain

ip=`cat  /opt/engines/etc/net/public`
hostname=publichost
no_inarpra=1
add_to_internal_domain

wait  
exit_code=$?

rm /home/engines/run/flags/startup_complete
exit $exit_code
