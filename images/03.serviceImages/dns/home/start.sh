#!/bin/sh


grep BLANK /var/lib/bind/engines/engines.dnsrecords >/dev/null
if test $? -eq 0
 then
	ip=`echo -n  `grep mgmt /etc/hosts|awk '{print $1}' |cut -d. -f-3`.1`
	cat  /etc/bind/templates/engines.internal.domain.tmpl |sed "/IP/s//$ip/" > /var/lib/bind/engines/engines.dnsrecords
 fi

PID_FILE=/var/run/named/named.pid
export PID_FILE
. /home/trap.sh


mkdir -p /engines/var/run/flags/


sudo /home/setup.sh

sudo -n syslogd  -R syslog.engines.internal:5140
sudo -n /usr/sbin/named  -c /etc/bind/named.conf -f -u bind & 
touch /engines/var/run/flags/startup_complete
wait  

rm /engines/var/run/flags/startup_complete
