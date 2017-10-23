#!/bin/sh

if ! test -d /var/run/named
 then
	mkdir -p /var/run/named
	chown -R bind /var/run/named
fi
if ! test -d /var/log/named
 then 	
   mkdir -p /var/log/named
   chown -R bind /var/log/named
fi

ip_r=`grep dns /etc/hosts|awk '{print $1}' |cut -d. -f-3`
ip=${ip_r}.1
net=`echo $ip_r |awk  ' BEGIN { FS="."} {print $2 "." $1}'`

cd /tmp

/usr/sbin/dnssec-keygen -a HMAC-MD5 -b 128 -n HOST  -r /dev/urandom -n HOST DDNS_UPDATE >/dev/null
mv *private /etc/bind/keys/ddns.private
mv *key /etc/bind/keys/ddns.key

key=`cat /etc/bind/keys/ddns.private |grep Key | cut -f2 -d" "`
cp /home/engines/templates/dns/named.conf.default-zones.start /etc/bind/named.conf.default-zones;\

echo "secret \"$key\";" >> /etc/bind/named.conf.default-zones;\
cat /home/engines/templates/dns/named.conf.default-zones.end  | sed "/NET/s//$net/">> /etc/bind/named.conf.default-zones
chown bind -R /etc/bind/keys/