#/bin/bash

ln -s /engines/ssl/keys/ipvpn.key /etc/ipsec.d/private/
ln -s /engines/ssl/certs/ipvpn.crt /etc/ipsec.d/certs/  
ln -s /usr/local/share/ca-certificates/engines_internal_ca.crt  /etc/ipsec.d/cacerts/     

domain=`cat /engines/ssl/certs/ipvpn.crt | openssl x509 -noout -subject  |sed "/^.*CN=/s///"`

if test -f /home/configurators/saved/rw_subnet
then
 subnet=`cat /home/configurators/saved/rw_subnet`
else
 subnet=10.1.1.0
fi
if test -f /home/configurators/saved/rw_mask
then
 mask=`cat /home/configurators/saved/rw_mask`
else
 mask=24
fi


cat /home/tmpls/ipsec.conf.tmpl | sed "/COMMON_NAME/s//$domain/"\
 | sed "/RW_SUBNET/s//$subnet/"   | sed "/RW_MASK/s//$mask/"> /etc/ipsec.conf
chmod og-rwx /etc/ipsec.d/private/ipvpn.key /etc/ipsec.conf
 