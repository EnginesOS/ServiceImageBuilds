#!/bin/sh

mkdir -p /var/run/named
chown -R bind /var/run/named
mkdir -p /var/log/named
chown -R bind /var/log/named

cd /tmp

/usr/sbin/dnssec-keygen -a HMAC-MD5 -b 128 -n HOST  -r /dev/urandom -n HOST DDNS_UPDATE >/dev/null
mv *private /etc/bind/keys/ddns.private
mv *key /etc/bind/keys/ddns.key

key=`cat /etc/bind/keys/ddns.private |grep Key | cut -f2 -d" "`
cp /etc/bind/templates/named.conf.default-zones.start /etc/bind/named.conf.default-zones;\

echo "secret \"$key\";" >> /etc/bind/named.conf.default-zones;\
cat /etc/bind/templates/named.conf.default-zones.end >> /etc/bind/named.conf.default-zones
chown bind -R /etc/bind/keys/