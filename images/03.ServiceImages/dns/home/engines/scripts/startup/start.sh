#!/bin/sh

grep BLANK /var/lib/bind/engines/engines.dnsrecords >/dev/null

if test $? -eq 0
 then
   ip_r=`grep dns /etc/hosts|awk '{print $1}' |cut -d. -f-3`
   ip=${ip_r}.1
   net=`echo $ip_r |awk  ' BEGIN {  FS="."} {print $2 "." $1}'`
   cat  /home/engines/templates/dns/engines.internal.domain.tmpl |sed "/IP/s//$ip/" > /var/lib/bind/engines/engines.dnsrecords
   cat  /home/engines/templates/dns/engines.internal.in-addr.arpa.tmpl |sed "/NET/s//$net/g" > /var/lib/bind/engines/engines.in-addr.arpa.dnsrecords
fi


KILL_SCRIPT=/home/engines/scripts/signal/kill_bind.sh
export KILL_SCRIPT


PID_FILE=/home/engines/run/named.pid
export PID_FILE
. /home/engines/functions/trap.sh

sudo -n /home/engines/scripts/engine/sudo/_setup.sh

sudo -n /usr/sbin/named  -c /etc/bind/named.conf -f -u bind &

startup_complete

sleep 10
/home/engines/scripts/engine/create_int_ip_dns_records.sh
/home/engines/scripts/engine/create_ext_ip_dns_records.sh
wait  

exit_code=$?

shutdown_complete

