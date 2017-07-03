#/bin/bash

cp /etc/ssl/keys/ipvpn.key /etc/ipsec.d/private/
cp /etc/ssl/certs/ipvpn.crt /etc/ipsec.d/certs/  
cp /usr/local/share/ca-certificates/engines_internal_ca.crt  /etc/ipsec.d/cacerts/     

domain=`cat /etc/ssl/certs/ipvpn.crt | openssl x509 -noout -subject  |sed "/^.*CN=/s///"`

if test -f /home/configurators/rw_subnet
then
 subnet=`cat /home/configurators/rw_subnet`
else
 subnet=10.1.1.0/24
fi

cat /home/tmpls/ipsec.conf.tmpl | sed "/COMMON_NAME/s/$domain//"\
 | sed "/RW_SUBNET/s/$subnet//" > /etc/ipsec.conf
chmod og-rwx /etc/ipsec.d/private/ipvpn.key /etc/ipsec.conf
 