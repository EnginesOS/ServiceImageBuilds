#/bin/bash

ln -s /home/engines/etc/ssl/keys/ivpn.key /etc/ipsec.d/private/
ln -s /home/engines/etc/ssl/certs/ivpn.crt /etc/ipsec.d/certs/  
ln -s /home/engines/etc/ssl/engines_internal_ca.crt  /etc/ipsec.d/cacerts/     

domain=`cat /home/engines/etc/ssl/certs/ivpn.crt | openssl x509 -noout -subject  |sed "/^.*CN=/s///"`

if test -f /home/engines/scripts/configurators/saved/rw_subnet
then
 subnet=`cat /home/engines/scripts/configurators/saved/rw_subnet`
else
 subnet=10.1.1.0
fi
if test -f /home/engines/scripts/configurators/saved/rw_mask
then
 mask=`cat /home/engines/scripts/configurators/saved/rw_mask`
else
 mask=24
fi

secret=SECRET

cat /home/engines/templates/eap-radius.conf | sed "/SECRET/s//$secret/" \
  > /etc/strongswan.d/charon/eap-radius.conf
  
cat /home/engines/templates/ipsec.conf.tmpl | sed "/COMMON_NAME/s//$domain/"\
 | sed "/RW_SUBNET/s//$subnet/"   | sed "/RW_MASK/s//$mask/"> /etc/ipsec.head
 
cp /etc/ipsec.head /etc/ipsec.conf
 
chmod og-rwx /etc/ipsec.d/private/ipvpn.key /etc/ipsec.conf /etc/strongswan.d/charon/eap-radius.conf /etc/ipsec.conf
 