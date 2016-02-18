#!/bin/sh

if ! test -f /tmp/setup
 then
	/home/setup.sh
	touch /tmp/setup
fi 

grep BLANK /var/lib/bind/engines/engines.dnsrecords >/dev/null
if test $? -eq 0
 then
 ip_r=`grep dns /etc/hosts|awk '{print $1}' |cut -d. -f-3`
ip=${ip_r}.1
net=`echo $ip_r |awk  ' BEGIN {  FS="."} {print $2 "." $1}'`
cat  /etc/bind/templates/engines.internal.domain.tmpl |sed "/IP/s//$ip/" > /var/lib/bind/engines/engines.dnsrecords
cat  /etc/bind/templates/engines.internal.in-addr.arpa.tmpl |sed "/NET/s//$net/g" > /var/lib/bind/engines/engines.in-addr.arpa.dnsrecords
 fi

PID_FILE=/var/run/named/named.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/


sudo /home/setup.sh

sudo -n syslogd  -R syslog.engines.internal:514
sudo -n /usr/sbin/named  -c /etc/bind/named.conf -f -u bind & 
touch /engines/var/run/flags/startup_complete
wait  

rm /engines/var/run/flags/startup_complete
